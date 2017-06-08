class AdminController < ApplicationController
  before_action :restrict_to_admins

  def index
  end

  private

  def restrict_to_admins
    unless current_user.admin?
      flash[:alert] = 'Insufficient Permissions'
      redirect_to root_path
    end
  end
end