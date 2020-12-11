class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  PER = 8

  def index
    if logged_in?
      @tasks = current_user.tasks.page(params[:page]).per(PER)
      @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
        if params[:sort_expired] != nil
          @tasks = current_user.tasks.order(expired_at: :asc).page(params[:page]).per(PER)
        elsif params[:sort_priority] != nil
          @tasks = current_user.tasks.order(priority: :asc).page(params[:page]).per(PER)
        elsif params[:title].present? && params[:status].present?
          @tasks = current_user.tasks.both_title_status(params[:title], params[:status]).page(params[:page]).per(PER)
        elsif params[:title].present? && params[:status].blank?
          @tasks = current_user.tasks.only_title(params[:title]).page(params[:page]).per(PER)
        elsif params[:title].blank? && params[:status].present?
          @tasks = current_user.tasks.only_status(params[:status]).page(params[:page]).per(PER)
        end
    else
      redirect_to new_session_path
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: t('notice.create') }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: t('notice.update') }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: t('notice.destroy') }
      format.json { head :no_content }
    end
  end

  private
  def set_task
      @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority, { label_ids: [] })
  end

  def update_task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end
end
