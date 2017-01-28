class BillsController < ApplicationController
  def index
    @bills = Bill.all
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
    @bill.cents = params[:bill][:dollars].to_i*100 + params[:bill][:cents].to_i
    if @bill.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @bill = Bill.find(params[:id])
  end

  def update
    @bill = Bill.find(params[:id])
    @bill.assign_attributes(bill_params)
    @bill.cents = params[:bill][:dollars].to_i*100 + params[:bill][:cents].to_i
    if @bill.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    # TODO
  end

  def pay_bill
    @bill = Bill.find(params[:id])
    # do not process if bill is already paid
    render action: :show if @bill.paid
    apartment = @bill.apartment
    tenants = apartment.tenants
    tenants.each do |tenant|
      # skip the person paying the bill
      share = Share.new(bill_id: params[:id], user_id: tenant.id, apartment_id: apartment.id)
      if tenant.id == current_user.id
        share.cents = @bill.cents%tenants.count
      else
        share.cents = @bill.cents/tenants.count
      end
      share.save
    end
    @bill.paid = Time.now
    @bill.save
    render action: :show
  end

  private

  def bill_params
    params.require(:bill).permit(:apartment_id, :name, :user_id, :due)
  end

end
