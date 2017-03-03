class Debt < ApplicationRecord
  include PermanentObjects
  
  validates_presence_of :user_id, :name, :cents
  belongs_to :user
  has_many :payments
  attr_accessor :dollars
  validates :cents, numericality: { greater_than: 0 }

  def total_paid
    payments.sum(:cents)
  end

  def remaining
    cents - total_paid
  end
end
