class OrdersController < ApplicationController
  def new
    @q                = Product.ransack(params[:q])
    @order_items      = current_user.cart.cart_items.includes(:product).latest
    @total_price      = total_payment
    @current_cart     = current_user.cart
    @delivery_address = current_user.delivery_addresses.find_by(address: params[:address])

    respond_to do |format|
      format.html
      format.json do
        render json: {address: @delivery_address}
      end
    end
  end

  def create
    @cart_items = current_user.cart.cart_items
    generates_order
    if params[:payment_method] == 'card'
      generates_charge
      @order.update(status: 1)
    end
    redirect_to root_path
  end

  private

  def generates_order
    address = current_user.delivery_addresses.find_by(address: params[:address])
    @order = current_user.orders.create!(
      shipping_fee:         params[:shipping_fee].to_f,
      total_payment:        params[:total_payment].to_f,
      payment_method:       params[:payment_method],
      delivery_address_id:  address.id,
      cart_id:              current_user.cart.id,
      status:               0
    )
    @cart_items.map do |cart_item|
      @order.order_items.create!(
        price_pay:   cart_item.product.price,
        quantity:    cart_item.quantity,
        total_price: cart_item.total_price,
        product_id:  cart_item.product.id
      )
    end
    CartItem.where(cart_id: current_user.cart.id).delete_all

    flash[:notice] = 'Order success!'
  end

  def generates_charge
    card_token = Stripe::Token.create({
      card: {
        number:    params[:cart_number],
        exp_month: params[:expiration_date].split("/").first,
        exp_year:  '20' + params[:expiration_date].split("/").last,
        cvc:       '314',
      },
    })

    customer = Stripe::Customer.create(
      email:  params[:email_stripe],
      source: card_token.id
    )

    amount = total_payment + params[:shipping_fee].to_f

    charge = Stripe::Charge.create(
      amount:      amount.to_i,
      customer:    customer.id,
      currency:    'vnd',
      description: "Rails Stripe customer pay for #{current_user.cart.cart_items.size} products"
    )
  end
end
