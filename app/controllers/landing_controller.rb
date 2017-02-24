class LandingController < ApplicationController
  def home
    @apartments_bills = Reporter::Home.apartments_bills(current_user.id)
  end
end
