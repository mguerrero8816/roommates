class LandingController < ApplicationController
  def home
    @apartments_bills = HomeReporter.apartments_bills(current_user.id)
  end
end
