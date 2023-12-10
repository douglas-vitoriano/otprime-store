class Address < ApplicationRecord
  validates :name, :street, :neighborhood, :number, :zipcode, :city, :state, :user_id, presence: true

  belongs_to :user
end
