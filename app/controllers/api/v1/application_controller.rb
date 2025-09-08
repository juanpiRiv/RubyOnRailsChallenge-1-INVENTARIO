module Api
  module V1
    class ApplicationController < ActionController::API
      include ActionController::HttpAuthentication::Basic::ControllerMethods
      include ActionController::HttpAuthentication::Token::ControllerMethods

      attr_reader :current_user

      # Declare authenticate_user! as a before_action callback
      before_action :authenticate_user!

      def authenticate_user!
        @current_user = authenticate_with_http_token do |token, _options|
          User.find_by(authentication_token: token)
        end

        render json: { error: 'Token no válido o no proporcionado' }, status: :unauthorized unless @current_user
      end
    end
  end
end
