class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :status
      t.float :shipping_fee
      t.float :total_payment
      t.integer :payment_method
      t.string :email_stripe
      t.string :cart_number
      t.string :expiration_date
      t.string :cvc
      t.references :cart, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :delivery_address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
