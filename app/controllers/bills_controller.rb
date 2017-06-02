class BillsController < ApplicationController
  before_action :default_if_paid, only: [:edit, :update, :destroy, :pay]

  def index
    @user_bills = Reporter::UserBills.report(current_user.id)
  end

  def show
    @bill = Bill.find(params[:id])
  end

  def new
    @bill = Bill.new
    @apartment_id = params[:apartment_id]
  end

  def create
    @bill = Bill.new(bill_params)
    if @bill.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @bill.assign_attributes(bill_params)
    @bill.cents = params[:bill][:dollars].to_i*100 + params[:bill][:cents].to_i
    if @bill.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def get_split_users
    users = User.select('users.id, users.first_name, users.last_name').where('apartment_tenants.apartment_id = ?', params[:apartment_id]).joins('LEFT JOIN apartment_tenants ON users.id = apartment_tenants.user_id')
    render json: users
  end

  private

  def default_if_paid
    @bill = Bill.find(params[:id])
    if @bill.total_paid > 0
      # do not process if bill is already paid
      flash.notice = 'Payment must be deleted before bill can be modified'
      render action: :show
    end
  end

  def bill_params
    params.require(:bill).permit(:apartment_id, :name, :user_id, :due, :dollars, :cents)
  end

end
