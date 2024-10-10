class TasksController < ApplicationController
  before_action :authenticate_user!  # Ensure user is authenticated
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :task_not_found  # Handle missing tasks

  # GET /tasks
  def index
    @tasks = Task.where(status: 'incomplete')
    @task = Task.new
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.status = 'incomplete'  # New tasks are incomplete by default
    if @task.save
      redirect_to tasks_path
    else
      render :index
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :completed)  # Add other attributes if necessary
  end

  # DELETE /tasks/:id
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully deleted.'
  end

  # PATCH/PUT /tasks/:id
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = current_user.tasks.find(params[:id])  # Ensure user can only access their own tasks
  end

  # Handle task not found
  def task_not_found
    redirect_to tasks_path, alert: 'Task not found.'
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:name, :completed)  # Add other permitted fields if necessary
  end

  class TasksController < ApplicationController
    def index
      @tasks = Task.where(status: 'incomplete')
      @task = Task.new
    end
  
    def create
      @task = Task.new(task_params)
      @task.status = 'incomplete'  # New tasks are incomplete by default
      if @task.save
        redirect_to tasks_path
      else
        render :index
      end
    end
  
    def complete
      @task = Task.find(params[:id])
      @task.update(status: 'complete')
      redirect_to tasks_path
    end
  
    def completed
      @completed_tasks = Task.where(status: 'complete')
    end
  
    private
  
    def task_params
      params.require(:task).permit(:name)
    end
  end
end


