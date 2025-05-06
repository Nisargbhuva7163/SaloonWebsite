class ServicesController < ApplicationController
  before_action :set_service, only: [ :show, :edit, :update, :destroy ]

  def show
  end

  def new
    @service = Service.new
    @services = Service.all
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to new_service_path, notice: "Service created successfully"
    else
      @services = Service.all
      render :new
    end
  end

  def edit
  end

  def update
    if @service.update(service_params)
      redirect_to @service, notice: "Service updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @service.destroy
    redirect_to new_service_path, notice: "Service deleted successfully"
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :price)
  end
end
