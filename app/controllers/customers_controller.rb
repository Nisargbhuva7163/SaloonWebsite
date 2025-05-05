class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @customer = Customer.new
    @customers = Customer.all
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to new_customer_path, notice: "Customer created successfully"
    else
      @customers = Customer.all
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to new_customer_path, notice: "Customer updated successfully"
    else
      render :edit
    end
  end
  def destroy
    @customer.destroy
    redirect_to new_customer_path, notice: "Customer deleted successfully"
  end


  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :phone_number)
  end
end
