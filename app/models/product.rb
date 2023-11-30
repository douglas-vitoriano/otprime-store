class Product < ApplicationRecord
  validates :name, :description, :price, :category_id, :publish, presence: true

  belongs_to :category
end
