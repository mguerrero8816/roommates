class ApartmentsController < ApplicationController

  def index
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

  private

  def apartment_params
  end
end
