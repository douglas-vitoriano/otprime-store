class User < ApplicationRecord
  enum role: { admin: 0, customer: 1 }

  validates :name, :email, :role, :phone, :encrypted_password, :reset_password_token,
            :reset_password_sent_at, :remember_created_at, presence: true

  validates :id, uniqueness: { scope: :email }
end
