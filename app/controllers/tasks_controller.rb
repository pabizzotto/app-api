class TasksController < ApplicationController

    before_action :authenticate!
    before_action :load_resources, only: [:new, :edit]


    def index
        @tasks = current_user.tasks.search(search_params)
    end

    def create
        @task = current_user.tasks.new(task_params)

        if @task.save
            head :ok
        else
            render json: { error: @task.errors.full_messages.first }, status: 422
        end
    end

    def destroy
        @task = current_user.tasks.find(params[:id])
        @task.destroy
        head :ok
    end

    def edit
        @task = current_user.tasks.find(params[:id])
    end

    def show
        @task = current_user.tasks.find(params[:id])
    end

    def update
        @task = current_user.tasks.find(params[:id])

        if @task.update(task_params)
            head :ok
        else
            render json: { error: @task.errors.full_messages.first }, status: 422
        end
    end

    def new;end

    private

    def search_params
        params.permit(:status, :start_date_beginning, :end_date_beginning, :start_date_conclusion, :end_date_conclusion)
    end

    def task_params
        params.permit(:title, :register_at, :duration, :description, :concluded_at, :status, category_ids: [])
    end

    def load_resources
        @statuses = Task.statuses.keys
        @categories = Category.all
    end

end