class Debt < ApplicationRecord
  include MoneyConversions
  include PermanentObjects

  validates_presence_of :user_id, :name
  belongs_to :user
  has_many :payments

  def total_paid(current_id=nil)
    if current_id
      payments.where('id != ? AND active = true', current_id).sum(:cents)
    else
      payments.where(active: true).sum(:cents)
    end
  end

  def remaining
    cents - total_paid
  end
end
