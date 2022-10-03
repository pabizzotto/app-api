class CategoriesController < ApplicationController

    
    before_action :load_resources, only: [:new, :edit, :index]
    before_action :authenticate!
    
    def index;end

    def create
        @category = Category.new(category_params)

        if @category.save
            head :created
        else
            render json: { error: @category.errors.full_messages.first }, status: 422
        end
    end

    def edit
        @category = Category.find(params[:id])
    end

    def show
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id])

        if @category.update(category_params)
            head :ok
        else
            render json: { error: @category.errors.full_messages.first }, status: 422
        end
    end

    def new;end

    def destroy
        @category = Category.find(params[:id])
        @category.destroy
        head :ok
    end

    private
    def category_params
        params.permit(:name, :parent_id)
    end

    def load_resources
        @categories = Category.all
    end

end