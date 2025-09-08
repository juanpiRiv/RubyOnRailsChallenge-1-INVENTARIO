class ArticulosController < ApplicationController
  allow_unauthenticated_access only: :index
  before_action :set_articulo, only: %i[ show edit update destroy ]

  # GET /articulos or /articulos.json
  def index
    @articulos = Articulo.all
    @articulos = @articulos.filter_by_marca(params[:marca]) if params[:marca].present?
    @articulos = @articulos.filter_by_modelo(params[:modelo]) if params[:modelo].present?
    @articulos = @articulos.filter_by_fecha_desde(params[:fecha_desde]) if params[:fecha_desde].present?
    @articulos = @articulos.filter_by_fecha_hasta(params[:fecha_hasta]) if params[:fecha_hasta].present?

    respond_to do |format|
      format.html
      format.json
      format.csv { send_data Articulo.to_csv(@articulos), filename: "articulos-#{Date.today}.csv" }
    end
  end

  # GET /articulos/1 or /articulos/1.json
  def show
  end

  # GET /articulos/new
  def new
    @articulo = Articulo.new
  end

  # GET /articulos/1/edit
  def edit
  end

  # POST /articulos or /articulos.json
  def create
    @articulo = Articulo.new(articulo_params)

    respond_to do |format|
      if @articulo.save
        format.html { redirect_to @articulo, notice: "Articulo was successfully created." }
        format.json { render :show, status: :created, location: @articulo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articulos/1 or /articulos/1.json
  def update
    respond_to do |format|
      if @articulo.update(articulo_params)
        format.html { redirect_to @articulo, notice: "Articulo was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @articulo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articulos/1 or /articulos/1.json
  def destroy
    @articulo.destroy!

    respond_to do |format|
      format.html { redirect_to articulos_path, notice: "Articulo was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_articulo
      @articulo = Articulo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def articulo_params
      params.require(:articulo).permit(:modelo, :marca, :fecha_ingreso, :portador_id)
    end
end
