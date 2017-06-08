class Credit < Debt
  validates_presence_of :pay_to_id
  belongs_to :bill
end
