class Bill < ApplicationRecord
  belongs_to :apartment
  belongs_to :user
  has_one :payment
end
