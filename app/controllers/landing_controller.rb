class LandingController < ApplicationController
  def home
    @apartments_bills = Reporter::ApartmentsBills.report(current_user.id)
    @user_bills = Reporter::UserBills.report(current_user.id)
  end
end
