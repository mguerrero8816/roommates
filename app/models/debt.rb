class Debt < ApplicationRecord
  belongs_to :user
  belongs_to :bill

  validates_presence_of :bill_id
end
