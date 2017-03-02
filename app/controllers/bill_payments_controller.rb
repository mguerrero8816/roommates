class BillPaymentsController < ApplicationController
  def index
    @payment = Payment.new
    @bill = Bill.find(params[:bill_id]) if params[:bill_id]
  end

  def pay
    @payment = Payment.new(payment_params)
    @bill = Bill.find(params[:payment][:bill_id])
    if @payment.save
      Payment.last.split_credit
      redirect_to bill_path(@bill.id)
    else
      render :index
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:bill_id, :dollars, :cents, :paid)
  end
end
