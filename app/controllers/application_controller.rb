class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def cents_to_dollars(form_key)
    params[form_key][:dollars].to_i*100 + params[form_key][:cents].to_i
  end

  def restrict_to_owner(object, redirect_path)
    owner = object.user_id == current_user.id
    redirect_to redirect_path unless owner
  end
end
