class Bill < Debt
  validates_presence_of :apartment_id
  belongs_to :apartment

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
end
