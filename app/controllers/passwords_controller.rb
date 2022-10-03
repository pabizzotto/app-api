class PasswordsController < ApplicationController
    def create
        if user = User.find_by(email: params[:email])
            @token = user.send(:set_reset_password_token)
            render json: { token: @token }, status: :ok
        else
            render json: { error: 'User not found' }, status: :not_found
        end
    end

    def update
        if User.reset_password_by_token(password_params)
            head :ok
        else
            render json: { error: 'Invalid token' }, status: :unauthorized
        end
    end

    private

    def password_params
        params.permit(:reset_password_token, :password, :password_confirmation)
    end
end 