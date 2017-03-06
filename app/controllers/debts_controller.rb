class DebtsController < ApplicationController
  def index
    @user_debts = Reporter::UserDebts.report(current_user.id)
  end
end
