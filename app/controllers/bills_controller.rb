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

  private

  def bill_params
    params.require(:bill).permit(:apartment_id, :name, :user_id, :due)
  end

end
