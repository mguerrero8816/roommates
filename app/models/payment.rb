class Payment < ActiveRecord::Base
  include MoneyConversions
  include PermanentObjects

  belongs_to :debt
  before_validation :bill_to_debt_id
  validate :cannot_overpay_bill
  validates_presence_of :paid
  after_save :split_if_paid_off

  ### EXTRA ATTRIBUTES ###
  attr_accessor :bill_id
  alias_attribute :bill_id, :debt_id
  def user_id
    debt.user_id
  end
  ### END EXTRA ATTRIBUTES ###

  def split_if_paid_off
    debt.split_credit if debt.total_paid
  end

  private

  def cannot_overpay_bill
    overpaid = (debt.total_paid(id) + cents) > debt.cents
    errors.add(debt.type.pluralize, 'cannot be overpaid') if overpaid
  end

  def bill_to_debt_id
    self.debt_id = bill_id if bill_id
  end
end
