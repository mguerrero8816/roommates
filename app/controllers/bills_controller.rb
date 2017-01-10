class BillsController < ApplicationController
  def index
    @bills = Bill.all
  end

  def new
    @bill = Bill.new
    @apartment_id = params[:apartment_id]
  end
end
