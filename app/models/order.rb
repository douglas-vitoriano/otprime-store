class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :user

  belongs_to :status, optional: true
  belongs_to :payment_method, optional: true

  enum payment_method: { credit_card: :credit_card, paypal: :paypal }
  enum status: { awaiting_payment: :awaiting_payment, processing: :processing, done: :done }

  def total_price
    product.price * quantity
  end
end
