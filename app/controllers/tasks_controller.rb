class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  PER = 8

  def index
    #@tasks = Task.all
    @tasks = Task.page(params[:page]).per(PER)
      if params[:sort_expired] != nil
        @tasks = Task.order(expired_at: :asc)
      elsif params[:sort_priority] != nil
        @tasks = Task.order(priority: :asc)
      elsif params[:title].present? && params[:status].present?
        @tasks = Task.both_title_status(params[:title], params[:status])
      elsif params[:title].present? && params[:status].blank?
        @tasks = Task.only_title(params[:title])
      elsif params[:title].blank? && params[:status].present?
        @tasks = Task.only_status(params[:status])
      end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

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
      if @task.update(update_task_params)
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
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end

  def update_task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end
end
