class Payment < ActiveRecord::Base
  include MoneyConversions
  include PermanentObjects

  belongs_to :payable, polymorphic: true
  validate :cannot_overpay_bill
  validates_presence_of :paid
  after_save :split_if_paid_off

  def user_id
    payable.user_id if payable_type == 'Debt'
  end

  def split_if_paid_off
    payable.split_credit if payable_type == 'Debt' && payable.paid_off
  end

  private

  def cannot_overpay_bill
    overpaid = (payable.total_paid(id) + cents) > payable.cents
    errors.add(payable_type.pluralize, 'cannot be overpaid') if overpaid
  end
end
