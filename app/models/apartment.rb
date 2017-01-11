class Apartment < ApplicationRecord
  has_many :bills
  has_many :apartment_tenants
  has_many :users, through: :apartment_tenants
  alias_attribute :tenants, :users

  class << self
    def select_options
      all.map do |apartment|
        ["#{apartment.name} (#{apartment.address})", apartment.id]
      end
    end
  end
end
