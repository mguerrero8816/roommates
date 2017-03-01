class Payment < ActiveRecord::Base
  belongs_to :debt
  attr_accessor :dollars
  validates :cents, numericality: { greater_than: 0 }

  def split_credit
    debt.apartment.tenants.each do |user|
      # skip the person who paid the debt
      next if debt.user_id == user.id
      credit_name = "Payment to #{debt.user.full_name} for #{debt.name} paid on #{paid}"
      Credit.create(user_id: user.id, name: credit_name, pay_to_id: debt.user_id, cents: cents/(debt.apartment.tenants.count-1))
    end
  end
end
