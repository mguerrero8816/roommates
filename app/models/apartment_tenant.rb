class ApartmentTenant < ApplicationRecord
  belongs_to :apartment
  belongs_to :user
  attr_accessor :amount_paid
end
