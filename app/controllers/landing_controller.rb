class LandingController < ApplicationController
  def home
    @apartments_bills = Reporter::ApartmentsBills.report(current_user.id)
  end
end
