module Api
  class TasksController < ApplicationController
    before_action :load_task, only: %i(show update destroy)
    before_action :check_params, except: %i(index show destroy)

    def index
      response_success Task.all.map(&:json_data)
    end

    def create
      @task = Task.new task_params
      if @task.save
        response_success @task.json_data
      else
        response_error message: "Create failed"
      end
    end

    def show
      response_success @task.json_data
    end

    def update
      if @task.update task_params
        response_success @task.json_data
      else
        response_error message: "Update failed"
      end
    end

    def destroy
      if @task.destroy
        response_success
      else
        response_error message: "Destroy failed"
      end
    end

    private

    def check_params
      return if params[:task]
      response_error message: "Missing params"
    end

    def task_params
      params.require(:task).permit :content, :is_done
    end

    def load_task
      @task = Task.find_by id: params[:id]
      return if @task
      response_not_found
    end
  end
end
