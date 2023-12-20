class Cart < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :products, through: :orders

  validates :user, presence: true

  def total_price
    total = orders.order(:created_at).sum { |order| order.product&.price.to_f * order.quantity }
    Rails.logger.info "Total Price: #{total}"
    total
  end
end
