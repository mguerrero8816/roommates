class Bill < Debt
  validates_presence_of :apartment_id
  belongs_to :apartment
  after_create :split_credit
  has_many :credits

  def split_credit
    split_factor = apartment.tenants.count
    last_payment = active_payments.last
    credit_name = "Credit for #{name} Due: (#{due.strftime('%m/%d/%y')})"
    apartment.tenants.each do |user|
      # skip the person who paid the debt
      next if user_id == user.id
      Credit.create(user_id: user.id, apartment_id: apartment_id, bill_id: id, name: credit_name, pay_to_id: user_id, cents: cents/split_factor, active: false)
    end
  end

  def activate_splits
    credits.each{|credit| credit.update_attributes(active: true) }
  end
end
