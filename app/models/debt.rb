class Debt < ApplicationRecord
  belongs_to :user
  belongs_to :apartment
  has_many :payments
  attr_accessor :dollars
  validates :cents, numericality: { greater_than: 0 }

  def total_paid
    payments.sum(:cents)
  end
end
