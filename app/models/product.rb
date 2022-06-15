class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items
  has_many :order_items
  scope :product_residual, -> { where("residual > ?", 0) }
end
