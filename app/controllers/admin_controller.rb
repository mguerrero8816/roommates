class AdminController < ApplicationController
  before_action :restrict_to_admins

  def index
    @users = User.all
    @roles = Role.all
  end
end
