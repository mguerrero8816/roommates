class Debt < ApplicationRecord
  include MoneyConversions
  include PermanentObjects

  validates_presence_of :user_id, :name
  belongs_to :user
  has_many   :payments, dependent: :destroy, as: :payable

  def active_payments
    payments.where(active: true).order(:paid)
  end

  def inactive_payments
    payments.where(active: false).order(:paid)
  end

  def paid_off
    total_paid == cents
  end

  def remaining
    cents - total_paid
  end

  def total_paid(current_id=nil)
    if current_id
      active_payments.where('id != ?', current_id).sum(:cents)
    else
      active_payments.sum(:cents)
    end
  end
end
