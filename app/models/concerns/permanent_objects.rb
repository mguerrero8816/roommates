module PermanentObjects
  extend ActiveSupport::Concern
  included do
    before_validation :default_to_active
    validates :active, inclusion: { in: [ true, false ] }
  end

  def default_to_active
    self.active = true if active.nil?
  end

  def activate
    self.active = true
  end

  def deactivate
    self.active = false
  end
end
