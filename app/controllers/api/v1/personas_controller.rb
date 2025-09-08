module Api
  module V1
    class PersonasController < Api::V1::ApplicationController
      before_action :authenticate_user!, except: [:index, :show]
      before_action :set_persona, only: %i[ show update destroy ]

      def index
        @personas = Persona.all
        render json: @personas, status: :ok
      end

      def show
        render json: @persona.as_json(include: :articulos).merge(transferencias: @persona.todas_las_transferencias), status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Persona not found" }, status: :not_found
      end

      def create
        @persona = Persona.new(persona_params)
        if @persona.save
          render json: @persona, status: :created
        else
          render json: { errors: @persona.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @persona.update(persona_params)
          render json: @persona, status: :ok
        else
          render json: { errors: @persona.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @persona.destroy
        head :no_content
      end

      private

      def set_persona
        @persona = Persona.find(params[:id])
      end

      def persona_params
        params.require(:persona).permit(:nombre, :apellido)
      end
    end
  end
end
