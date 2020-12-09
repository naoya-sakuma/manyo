class Admin::UsersController < ApplicationController
  def new
    @admin_user = User.new
  end

  def index
    if current_user.admin?
      @admin_users = User.all.includes(:tasks)
    else
      redirect_to tasks_path, notice: '管理者のみ閲覧できるページです。'
    end
  end

  def create
    @admin_user = User.new(user_params)
    if @admin_user.save
      redirect_to admin_user_path(@admin_user.id)
    else
      render :new
    end
  end

  def show
    @admin_user = User.find(params[:id])
  end

  def edit
    @admin_user = User.find(params[:id])
  end

  def update
    @admin_user = User.find(params[:id])
    respond_to do |format|
      if @admin_user.update(user_params)
        format.html { redirect_to admin_user_path(@admin_user), notice: t('notice.update') }
        format.json { render :show, status: :ok, location: admin_user_path(@admin_user) }
      else
        format.html { render :edit }
        format.json { render json: admin_user_path(@admin_user).errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin_user = User.find(params[:id])
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: t('notice.destroy') }
      format.json { head :no_content }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def update_task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end
end
