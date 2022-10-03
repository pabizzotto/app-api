class SessionsController < ApplicationController
    def create
        user = User.find_for_database_authentication(email: params[:email])
        if user && user.valid_password?(params[:password])
            render json: { token: Token.new.encode(user) }, status: :ok
        else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
    end
end