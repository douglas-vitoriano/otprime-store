class Category < ApplicationRecord

  validates :name, :position, presence: true

  validates :name, uniqueness: true

end
