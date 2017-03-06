class CreditsController < ApplicationController
  def index
    @user_credits = Reporter::UserCredits.report(current_user.id)
  end
end
