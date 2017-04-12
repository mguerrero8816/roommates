class UserPaymentsController < ApplicationController

  def index
  end

  def new
    @payment = Payment.new
  end

  def pay
  end
end
