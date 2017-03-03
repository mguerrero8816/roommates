class Payment < ActiveRecord::Base
  include MoneyConversions
  include PermanentObjects
  
  belongs_to :debt
  attr_accessor :dollars, :bill_id
  before_validation :bill_to_debt_id, :add_dollars_to_cents
  validates :cents, numericality: { greater_than: 0 }
  validate :cannot_overpay_bill
  validates_presence_of :paid

  def split_credit
    debt.apartment.tenants.each do |user|
      # skip the person who paid the debt
      next if debt.user_id == user.id
      credit_name = "Payment to #{debt.user.full_name} for #{debt.name} paid on #{paid}"
      Credit.create(user_id: user.id, name: credit_name, pay_to_id: debt.user_id, cents: cents/(debt.apartment.tenants.count-1))
    end
  end

  private

  def cannot_overpay_bill
    overpaid = (debt.total_paid + cents) > debt.cents
    errors.add(debt.type.pluralize, 'cannot be overpaid') if overpaid
  end

  def bill_to_debt_id
    self.debt_id = bill_id if bill_id
  end
end
