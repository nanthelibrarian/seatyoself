class User < ActiveRecord::Base
  has_many :reservations
  has_many :restaurants, through: :reservations
  has_many :restaurants
  has_secure_password

  def owner?
    role == "owner"
  end
end
