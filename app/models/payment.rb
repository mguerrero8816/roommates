class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :apartment
  has_many :splitters
  has_many :users, through: :splitters
  alias_attribute :payer, :user
  alias_attribute :splitters, :users
end
