class Bill < Debt
  attr_accessor :special_split
  validates_presence_of :apartment_id
  belongs_to :apartment
  after_create :split_credit
  has_many :credits, dependent: :destroy

  def split_credit
    credit_name = "Credit for #{name} Due: (#{due.strftime('%m/%d/%y')})"
    special_split.present? ? special_split_logic(credit_name) : even_split_logic(credit_name)
  end

  private

  def special_split_logic(credit_name)
    special_split.each do |split_user_id, amounts|
      next if user_id == split_user_id.to_i
      split_cents = 100*amounts[:dollars].to_i + amounts[:cents].to_i
      Credit.create!(user_id: split_user_id.to_i, apartment_id: apartment_id, bill_id: id, name: credit_name, pay_to_id: user_id, cents: split_cents, active: false)
    end
  end

  def even_split_logic(credit_name)
    split_factor = apartment.tenants.count
    apartment.tenants.each do |user|
      # skip the person who paid the debt
      next if user_id == user.id
      Credit.create!(user_id: user.id, apartment_id: apartment_id, bill_id: id, name: credit_name, pay_to_id: user_id, cents: cents/split_factor, active: false)
    end
  end

  def activate_splits
    credits.each{|credit| credit.update_attributes(active: true) }
  end
end
