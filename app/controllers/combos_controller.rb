class CombosController < ApplicationController
  before_action :set_combo, only: [ :show, :edit, :update, :destroy ]

  def new
    @combo = Combo.new
    @combos = Combo.all
    @services = Service.all
  end

  def create
    @combo = Combo.new(combo_params)
    if @combo.save
      @combos = Combo.includes(:service).order(created_at: :desc)
      redirect_to new_combo_path, notice: "Combo created successfully"
    else
      @services = Service.all # <-- ensure @combos is present on error too
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @services = Service.all
  end

  def update
    if @combo.update(combo_params)
      redirect_to new_combo_path, notice: "Combo updated successfully"
    else
      @services = Service.all
      render :edit
    end
  end

  def show
  end

  def destroy
    @combo.destroy
    redirect_to new_combo_path, notice: "Combo deleted successfully"
  end

  private

  def set_combo
    @combo = Combo.find(params[:id])
  end

  def combo_params
    params.require(:combo).permit(:quantity, :service_id, :discount)
  end
end
