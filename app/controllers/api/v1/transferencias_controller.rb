module Api
  module V1
    class TransferenciasController < Api::V1::ApplicationController
      before_action :authenticate_user!, except: [:index, :show]
      before_action :set_transferencia, only: %i[ show update destroy ]

      def index
        @transferencias = Transferencia.all
        render json: @transferencias.as_json(include: [:articulo, :portador_anterior, :nuevo_portador]), status: :ok
      end

      def show
        render json: @transferencia.as_json(include: [:articulo, :portador_anterior, :nuevo_portador]), status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Transferencia not found" }, status: :not_found
      end

      def create
        @transferencia = Transferencia.new(transferencia_params)
        @articulo = Articulo.find(transferencia_params[:articulo_id])
        @transferencia.portador_anterior_id = @articulo.portador_id

        ActiveRecord::Base.transaction do
          @transferencia.save!
          @articulo.update!(portador_id: @transferencia.nuevo_portador_id)
        end

        render json: @transferencia, status: :created
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def update
        if @transferencia.update(transferencia_params)
          render json: @transferencia, status: :ok
        else
          render json: { errors: @transferencia.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @transferencia.destroy
        head :no_content
      end

      private

      def set_transferencia
        @transferencia = Transferencia.find(params[:id])
      end

      def transferencia_params
        params.require(:transferencia).permit(:articulo_id, :nuevo_portador_id, :fecha)
      end
    end
  end
end
