module Api
  module V1
    class ArticulosController < Api::V1::ApplicationController
      # Apply authentication to all article endpoints except index and show,
      # assuming these might be public. If all should be protected, remove the 'only' option.
      before_action :authenticate_user!, except: [:index, :show]
      before_action :set_articulo, only: %i[ show update destroy ]

      def index
        @articulos = Articulo.all
        render json: @articulos, status: :ok
      rescue ActiveRecord::RecordNotFound => e # Catch potential errors from finding records
        Rails.logger.error "Error fetching articles: #{e.message}"
        render json: { error: "Could not retrieve articles. Please try again later." }, status: :unprocessable_entity
      end

      def show
        render json: @articulo, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Articulo not found" }, status: :not_found
      end

      def create
        @articulo = Articulo.new(articulo_params)
        if @articulo.save
          render json: @articulo, status: :created
        else
          render json: { errors: @articulo.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @articulo.update(articulo_params)
          render json: @articulo, status: :ok
        else
          render json: { errors: @articulo.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @articulo.destroy
        head :no_content
      end

      private

      def set_articulo
        @articulo = Articulo.find(params[:id])
      end

      def articulo_params
        params.require(:articulo).permit(:modelo, :marca, :fecha_ingreso, :portador_id)
      end
    end
  end
end
