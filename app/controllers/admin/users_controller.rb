class Admin::UsersController < AdminController
  def show
  end

  def new
    @user = User.new
  end

  def create
    # @user = User.new(user_params)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_index_path, notice: 'User was successfully updated'
    else
      flash[:alert] = 'User was not updated'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_index_path, notice: 'User was successfully deleted'
    else
      redirect_to admin_index_path, alert: 'User was not deleted'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end