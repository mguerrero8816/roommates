class Admin::UsersController < AdminController
  def show
  end

  def new
    @user = User.new
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
    else
    end
    redirect_to admin_index_path
  end
end