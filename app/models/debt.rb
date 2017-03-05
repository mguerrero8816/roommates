class Debt < ApplicationRecord
  include MoneyConversions
  include PermanentObjects

  validates_presence_of :user_id, :name
  belongs_to :user
  has_many :payments

  def active_payments
    payments.where(active: true).order(:paid)
  end

  def inactive_payments
    payments.where(active: false).order(:paid)
  end

  def split_credit
    split_factor = apartment.tenants.count
    debt_owner = user.full_name
    last_payment = active_payments.last
    credit_name = "Payment to #{debt_owner} for #{name} fully paid on #{last_payment.paid}"
    apartment.tenants.each do |user|
      # skip the person who paid the debt
      next if user_id == user.id
      Credit.create(user_id: user.id, name: credit_name, pay_to_id: user_id, cents: cents/split_factor)
    end
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
