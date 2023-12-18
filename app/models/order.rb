class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  has_one :user, through: :cart

  enum payment_method: { credit_card: :credit_card, paypal: :paypal }
  enum status: { awaiting_payment: :awaiting_payment, processing: :processing, done: :done }

  def total_price
    product.price * quantity
  end
end
