class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_length_of :password, minimum: 5
end
