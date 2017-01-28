class Bill < Debt
  has_many :shares
  belongs_to :apartment
  validates_presence_of :name
end
