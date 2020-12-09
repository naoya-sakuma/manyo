class Admin::UsersController < ApplicationController
  def index
    @admin_users = User.all
  end

  def show
    @admin_user = User.find(params[:id])
  end

  def edit
    @admin_user = User.find(params[:id])
  end

  def update
    respond_to do |format|
      if @admin_user.update(update_task_params)
        format.html { redirect_to @admin_user, notice: t('notice.update') }
        format.json { render :show, status: :ok, location: @admin_user }
      else
        format.html { render :edit }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: t('notice.destroy') }
      format.json { head :no_content }
    end
  end

end
