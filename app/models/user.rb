class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :phone_number, presence: true

  enum role: { user: "user", admin: "admin" }
  #enum role: [:user, :admin], tbm pode ser utilizado array

end
