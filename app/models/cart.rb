class Cart < ApplicationRecord
  belongs_to :user
  has_many :orderables
  has_many :products, through: :orderables
  has_many :addresses

  def total_price
    orderables.sum { |orderable| orderable.product&.price.to_f * orderable.quantity }
  end
end
