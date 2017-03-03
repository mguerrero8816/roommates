module MoneyConversions
  extend ActiveSupport::Concern
  included do
    attr_accessor :dollars
    before_validation :add_dollars_to_cents
    validates_presence_of :cents
    validates :cents, numericality: { greater_than: 0 }
  end

  def add_dollars_to_cents
    self.cents = cents.to_i + dollars.to_i*100
  end
end
