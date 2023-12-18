class Cart < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy

  def total_price
    orders.order(:created_at).sum { |order| order.product&.price.to_f * order.quantity }
  end
end
