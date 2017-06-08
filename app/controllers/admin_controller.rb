class AdminController < ApplicationController
  before_action :restrict_to_admins

  def index
  end

  private

  def restrict_to_admins
  end
end