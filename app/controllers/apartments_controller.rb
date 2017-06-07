class ApartmentsController < ApplicationController
  def tenants
    users = User.select('users.id, users.first_name, users.last_name').where('apartment_tenants.apartment_id = ?', params[:id]).joins('LEFT JOIN apartment_tenants ON users.id = apartment_tenants.user_id').order('users.last_name')
    render json: users
  end
end
