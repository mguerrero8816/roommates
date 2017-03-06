class Bill < Debt
  validates_presence_of :apartment_id
  belongs_to :apartment

  def split_credit
    split_factor = apartment.tenants.count
    debt_owner = user.full_name
    last_payment = active_payments.last
    credit_name = "Credit for #{name} (#{last_payment.paid.strftime('%m/%d/%y')})"
    apartment.tenants.each do |user|
      # skip the person who paid the debt
      next if user_id == user.id
      Credit.create(user_id: user.id, apartment_id: apartment_id, bill_id: id, name: credit_name, pay_to_id: user_id, cents: cents/split_factor)
    end
  end
end
