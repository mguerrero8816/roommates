class PaymentsController < ApplicationController
  def index
    @payments = Payment.all
  end

  def new
    @payment = Payment.new
    @debt = Debt.find(params[:debt_id]) if params[:debt_id]
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.cents = cents_to_dollars(:payment)
    @debt = Debt.find(params[:payment][:debt_id])
    if @payment.save
      if @debt.type == 'Bill'
        Payment.last.split_credit
        redirect_to bill_path(@debt.id)
      end
    else
      render :new
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:debt_id, :dollars, :cents, :paid)
  end
end
