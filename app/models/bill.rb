class Bill < Debt
  validates_presence_of :apartment_id
  belongs_to :apartment
end
