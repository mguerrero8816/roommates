class BillsController < ApplicationController
  def index
    @bills = Bill.all
  end

  def new
    @bill = Bill.new
    @apartment_id = params[:apartment_id]
  end

  def create
    @bill = Bill.new(bill_params)
    @bill.cents = params[:dollars].to_i*100 + params[:cents].to_i
    @bill.paid = params[:confirm_pay] ? params[:paid] : nil
    if @bill.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @bill = Bill.find(params[:id])
  end

  def updated
    # TODO
  end

  def destroy
    # TODO
  end

  private

  def bill_params
    params.require(:bill).permit(:apartment_id, :name, :user_id, :due)
  end

end
