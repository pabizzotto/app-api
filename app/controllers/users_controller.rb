class UsersController < ApplicationController

    before_action :authenticate!, only: [:update]

    def create
        @user = User.new(user_params)
        if @user.save
            head :created
        else
            render json: { error: @user.errors.full_messages.first }, status: 422
        end
    end

    def update
        @user = User.find(params[:id])

        if @user.update(user_params)
            render json: { token: Token.new.encode(@user) }, status: :ok
        else
            render json: { error: @user.errors.full_messages.first }, status: 422
        end
    end

    private
    def user_params
        params.permit(:email, :password, :password_confirmation, :name, :view)
    end

end