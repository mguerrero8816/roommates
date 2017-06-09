class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :apartment_users
  has_many :apartments, through: :apartment_users
  has_many :role_users
  has_many :roles, through: :role_users

  after_update :update_roles
  attr_accessor :role_ids

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

  def dev?
    roles.uniq.pluck(:id).include?(1)
  end

  def admin?
    roles.uniq.pluck(:id).include?(2) || dev?
  end

  def owner?
    roles.uniq.pluck(:id).include?(3) || admin? || dev?
  end

  private

  def update_roles
    return if role_ids.nil?
    # get current role users
    new_role_ids = role_ids
    # remove unincluded roles from table and matching roles from new list
    role_users.each do |role_user|
      if new_role_ids.include?(role_user.role_id)
        new_role_ids -= [role_user.role_id]
      else
        role_user.destroy
      end
    end
    # add new ids
    new_role_ids.each do |role_id|
      RoleUser.create(user_id: id, role_id: role_id)
    end
  end
end
