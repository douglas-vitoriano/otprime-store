class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :phone, presence: true

  has_one_attached :avatar
  has_many :addresses, dependent: :destroy
  has_one :cart

  enum role: { user: "user", admin: "admin" }
end
