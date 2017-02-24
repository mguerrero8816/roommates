class Debt < ApplicationRecord
  attr_accessor :dollars
  validates :cents, numericality: { greater_than: 0 }
end
