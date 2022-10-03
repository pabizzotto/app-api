class ApplicationController < ActionController::API

    def current_user
        token = request.headers['Authorization'].to_s.gsub('Bearer ', '')
        @current_user ||= Token.new.decode(token)
    end

    def authenticate!
        unless current_user
            render json: { error: "Acess denied" }, status: :unauthorized
        end
    end
    
end
