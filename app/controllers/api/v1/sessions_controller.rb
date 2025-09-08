module Api
  module V1
    class SessionsController < Api::V1::ApplicationController
      before_action :authenticate_user!, only: [:destroy]

      def create
        user = User.find_by(email_address: params[:email_address].downcase)

        if user&.authenticate(params[:password])
          user.generate_authentication_token
          user.save
          # Ensure the token is returned in the correct format for the client
          render json: { user: user.email_address, authentication_token: "Token #{user.authentication_token}" }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      def destroy
        # The authenticate_user! callback ensures current_user is set if the token is valid
        if current_user
          current_user.update(authentication_token: nil)
          head :no_content
        else
          # This case should ideally not be reached if authenticate_user! works correctly
          render json: { error: 'Authentication token is invalid or expired' }, status: :unauthorized
        end
      end
    end
  end
end
