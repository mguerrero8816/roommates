class Payment < ApplicationRecord
  belongs_to :user
  alias_attribute :payer, :user
  has_many :splitters
  has_many :users, through: :splitters
end
