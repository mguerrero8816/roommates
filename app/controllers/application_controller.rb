class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def restrict_to_admins
    unless current_user.admin?
      flash[:alert] = 'Insufficient Permissions'
      redirect_to root_path
    end
  end

  def restrict_to_owner(object, redirect_path)
    owner = object.user_id == current_user.id
    redirect_to redirect_path unless owner
  end
end
