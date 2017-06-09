class ApartmentsController < ApplicationController
  def tenants
    users = User.select('users.id, users.first_name, users.last_name').where('apartment_users.apartment_id = ?', params[:id]).joins('LEFT JOIN apartment_users ON users.id = apartment_users.user_id').order('users.last_name')
    render json: users
  end
end
