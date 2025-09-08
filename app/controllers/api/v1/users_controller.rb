module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      skip_before_action :authenticate_user!, only: [:create]

      def create
        user_params_normalized = user_params.dup
        email = user_params_normalized[:email_address].to_s.strip.downcase
        password = user_params_normalized[:password]
        password_confirmation = user_params_normalized[:password_confirmation]

        if email.blank? || password.blank? || password_confirmation.blank?
          return render json: { errors: ["Email, password, and password confirmation are required."] }, status: :unprocessable_entity
        end

        user_params_normalized[:email_address] = email

        @user = User.new(user_params_normalized)
        @user.generate_authentication_token # Explicitly generate token before save

        if @user.save
          render json: { user: @user.email_address, authentication_token: @user.authentication_token }, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      rescue => e # Catch any exception to help debug the 500 error
        Rails.logger.error "Error during user creation: #{e.message}\n#{e.backtrace.join("\n")}"
        render json: { error: "An internal error occurred during registration. Please try again later." }, status: :internal_server_error
      end

      private

      def user_params
        params.require(:user).permit(:email_address, :password, :password_confirmation)
      end
    end
  end
end
