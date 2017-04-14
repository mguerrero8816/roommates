class BillPaymentsController < ApplicationController
  before_action :set_and_restrict_object

  def index
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.payable = @bill
    if @payment.save
      redirect_to bill_path(@bill.id)
    else
      render :index
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:dollars, :cents, :paid)
  end

  def set_and_restrict_object
    @bill = Bill.find(params[:bill_id])
    restrict_to_owner(@bill, bill_path(@bill.id))
  end
end
