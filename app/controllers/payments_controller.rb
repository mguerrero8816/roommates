class PaymentsController < ApplicationController
  before_action :set_and_restrict_object

  def deactivate
    @payment.deactivate
    redirect_to :back
  end

  private

  def set_and_restrict_object
    @payment = Payment.find(params[:id])
    restrict_to_owner(@payment, bill_path(@payment.payable_id))
  end
end
