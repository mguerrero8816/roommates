class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :apartment_users
  has_many :apartments, through: :apartment_users

  has_many :role_users
  has_many :roles, through: :role_users

  class << self
    def select_options
      all.map do |user|
        [user.full_name, user.id]
      end
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    roles.uniq.pluck(:id).include?(1)
  end
end
