class TransferenciasController < ApplicationController
  allow_unauthenticated_access only: :index
  before_action :set_transferencia, only: %i[show edit update destroy]

  # GET /transferencias
  def index
    @transferencias = Transferencia.all
  end

  # GET /transferencias/1
  def show
  end

  # GET /transferencias/new
  def new
    @transferencia = Transferencia.new
  end

  # GET /transferencias/1/edit
  def edit
  end

  # POST /transferencias
  def create
    @transferencia = Transferencia.new(transferencia_params)
    @articulo = Articulo.find(transferencia_params[:articulo_id])
    @transferencia.portador_anterior_id = @articulo.portador_id

    if @transferencia.save
      @articulo.update(portador_id: @transferencia.nuevo_portador_id)
      redirect_to @transferencia, notice: "Transferencia was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transferencias/1
  def update
    if @transferencia.update(transferencia_params)
      redirect_to transferencia_path(@transferencia), notice: "Transferencia actualizada correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /transferencias/1
  def destroy
    @transferencia.destroy
    redirect_to transferencias_path, notice: "Transferencia eliminada correctamente."
  end

  private

  def set_transferencia
    @transferencia = Transferencia.find(params[:id])
  end

  def transferencia_params
    params.require(:transferencia).permit(:articulo_id, :nuevo_portador_id, :fecha)
  end
end
