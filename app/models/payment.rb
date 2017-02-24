class Payment < ActiveRecord::Base
  attr_accessor :dollars
  validates :cents, numericality: { greater_than: 0 }
end
