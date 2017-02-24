class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :apartment_tenants
  has_many :apartments, through: :apartment_tenants

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
end
