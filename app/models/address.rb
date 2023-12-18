class Address < ApplicationRecord
  belongs_to :user
  has_many :cart
  has_many :order
  validates :name, presence: true
end
