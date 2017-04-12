class UserPaymentsController < ApplicationController

  def index
    @payment = Payment.new
  end

  def create
  end
end
