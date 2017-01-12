class Bill < ApplicationRecord
  belongs_to :apartment
  belongs_to :user
  has_one :payment

  attr_accessor :dollars

  validates_presence_of :name
  validates :cents, numericality: { greater_than: 0 }

  private
end
