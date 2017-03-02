class BillPaymentsController < ApplicationController
  before_action :restrict_to_owner

  def index
    @payment = Payment.new
    @bill = Bill.find(params[:bill_id]) if params[:bill_id]
  end

  def pay
    @payment = Payment.new(payment_params)
    @payment.bill_id = params[:bill_id]
    @bill = Bill.find(params[:bill_id])
    if @payment.save
      Payment.last.split_credit
      redirect_to bill_path(@bill.id)
    else
      render :index
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:dollars, :cents, :paid)
  end

  def restrict_to_owner
    owner = Bill.find(params[:bill_id]).user_id == current_user.id
    redirect_to bill_path(params[:bill_id]) unless owner
  end
end
