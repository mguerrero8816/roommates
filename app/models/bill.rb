class Bill < ApplicationRecord
  belongs_to :apartment
  belongs_to :user
  has_one :payment

  attr_accessor :dollars
  attr_accessor :confirm_pay

  validates_presence_of :name
  validates :cents, numericality: { greater_than: 0 }

  private
end
