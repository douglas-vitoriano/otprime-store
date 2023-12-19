class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  has_one :user, through: :cart

  belongs_to :status
  belongs_to :payment_method

  enum payment_method: { credit_card: :credit_card, paypal: :paypal }
  enum status: { awaiting_payment: :awaiting_payment, processing: :processing, done: :done }

  def total_price
    product.price * quantity
  end
end
