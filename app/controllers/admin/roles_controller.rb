class Admin::RolesController < AdminController
  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to admin_index_path, notice: 'Role was successfully created'
    else
      flash[:alert] = 'Role was not created'
      render :new
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(role_params)
      redirect_to admin_index_path, notice: 'Role was successfully updated'
    else
      flash[:alert] = 'Role was not updated'
      render :edit
    end
  end

  def destroy
    @role = Role.find(params[:id])
    if @role.destroy
      redirect_to admin_index_path, notice: 'Role was successfully deleted'
    else
      redirect_to admin_index_path, alert: 'Role was not deleted'
    end
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end
end
