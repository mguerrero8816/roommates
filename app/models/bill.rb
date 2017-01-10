class Bill < ApplicationRecord
  belongs_to :apartment
  belongs_to :user
  has_one :payment

  attr_accessor :dollars
  attr_accessor :confirm_pay
end
