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
    @debt = Debt.find(params[:payment][:debt_id])
    if @debt.type == 'Bill'

    end
    p @payment
    p @debt
    1/0
  end

  def pay
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

  def payment_params
    params.require(:payment).permit(:debt_id, :paid)
  end
end
