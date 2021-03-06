class Apartment < ApplicationRecord
  has_many :debts
  has_many :apartment_users
  has_many :users, through: :apartment_users
  alias_attribute :tenants, :users

  class << self
    def select_options
      all.map do |apartment|
        ["#{apartment.name} (#{apartment.address})", apartment.id]
      end
    end
  end
end
