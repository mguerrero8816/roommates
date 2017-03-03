class Debt < ApplicationRecord
  include MoneyConversions
  include PermanentObjects

  validates_presence_of :user_id, :name
  belongs_to :user
  has_many :payments


  def total_paid
    payments.sum(:cents)
  end

  def remaining
    cents - total_paid
  end
end
