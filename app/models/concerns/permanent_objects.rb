module PermanentObjects
  extend ActiveSupport::Concern
  included do
    validates :active, inclusion: { in: [ true, false ] }
  end

  def activate
    self.active = true
    self.save
  end

  def deactivate
    self.active = false
    self.save
  end
end
