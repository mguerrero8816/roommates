module MoneyConversions
  extend ActiveSupport::Concern

  def add_dollars_to_cents
    self.cents = cents.to_i + dollars.to_i*100
  end
end
