class Debt < ApplicationRecord
  belongs_to :user
  attr_accessor :dollars
  validates :cents, numericality: { greater_than: 0 }
end
