class ApartmentsController < ApplicationController

  def index
    @apartments = Apartment.where('apartment_users.user_id = ?', current_user.id).joins('LEFT JOIN apartment_users ON apartments.id = apartment_users.apartment_id')
  end

  def show
    @apartment = Apartment.find(params[:id])
  end

  def new
    @apartment = Apartment.new
  end

  def create
    @apartment = Apartment.new(apartment_params)
  end

  def edit
    @apartment = Apartment.find(params[:id])
  end

  def update
    @apartment = Apartment.find(params[:id])
  end

  def destroy
  end

  def tenants
    users = User.select('users.id, users.first_name, users.last_name').where('apartment_users.apartment_id = ?', params[:id]).joins('LEFT JOIN apartment_users ON users.id = apartment_users.user_id').order('users.last_name')
    render json: users
  end

  def search
    query = params[:query].to_s.strip.squeeze(' ').upcase
    if query.to_s.length < 3
      render json: { error: 'search must be at least 3 characters' }
    else
      apartments = Apartment.where('UPPER(name) LIKE (?) OR UPPER(address) LIKE (?)', "%#{query}%", "%#{query}%")
      render json: apartments
    end
  end

  def join_multiple
    user_apartment_ids = current_user.apartments.uniq.pluck(:id)
    apartment_ids = params[:apartment_ids] || []
    apartment_ids -= user_apartment_ids
    apartment_ids.each do |apartment_id|
      ApartmentUser.create(user_id: current_user.id, apartment_id: apartment_id)
    end
    redirect_to apartments_path, notice: "#{apartment_ids.length} apartments were successfully joined"
  end

  def leave_multiple
    apartment_ids = params[:apartment_ids] || []
    ApartmentUser.where(user_id: current_user.id, apartment_id: apartment_ids).destroy_all
    redirect_to apartments_path, notice: "#{apartment_ids.length} apartments were successfully left"
  end

  private

  def apartment_params
  end
end
