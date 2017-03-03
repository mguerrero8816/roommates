class PaymentsController < ApplicationController
  before_action :set_and_restrict_object

  def destroy
    @payment.destroy
    redirect_to :back
  end

  private

  def set_and_restrict_object
    @payment = Payment.find(params[:payment_id])
    restrict_to_owner(@payment, bill_path(@payment.bill_id))
  end
end
