class UsersController < ApplicationController
  def current
    render json: User.select('id, first_name, last_name').where(id: current_user.id).last
  end
end
