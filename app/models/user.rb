class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: { contributor: 0, customer: 1 }

  has_many :products
  has_many :orders

  def set_customer!
    self.update!(user_type: User.user_types[:customer])
  end
end
