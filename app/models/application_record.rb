class ApplicationRecord < ActiveRecord::Base
  attr_accessor :amount_paid

  self.abstract_class = true
end
