class Debt < ApplicationRecord
  validates_presence_of :user_id
  validates_presence_of :name
  validates_presence_of :cents
  belongs_to :user
  has_many :payments
  attr_accessor :dollars
  validates :cents, numericality: { greater_than: 0 }

  def total_paid
    payments.sum(:cents)
  end
end
