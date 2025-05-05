class CustomerCombosController < ApplicationController
  before_action :set_selected_customer, only: [:assign_combo, :create]

  def index
    @customers = Customer.all
    @q = Customer.ransack(params[:q])
    @customers = @q.result(distinct: true)
  end

  def select_customer
    if params[:customer_ids].present?
          session[:selected_customer_ids] = params[:customer_ids]
          redirect_to assign_combo_customer_combos_path
        else
          redirect_to customer_combos_path, alert: "Please select at least one customer"
        end
  end

  def assign_combo
    @customers = Customer.where(id: session[:selected_customer_ids])
    @combos = Combo.all
  end

  def create
      combo = Combo.find_by(id: params[:combo_id])

      if combo && @customers.any?
        @customers.each do |customer|
          CustomerCombo.create(customer: customer, combo: combo)
        end

        session.delete(:selected_customer_ids)
        redirect_to customer_combos_path, notice: "Combo assigned to selected customers!"
      else
        redirect_to assign_combo_customer_combos_path, alert: "Combo assignment failed."
      end
  end

  private

  # Optional: If you need to ensure the customer is selected before performing an action
  def set_selected_customer
    customer_ids = session[:selected_customer_ids]
    @customers = Customer.where(id: customer_ids)
    redirect_to customer_combos_path, alert: "No customers selected." if @customers.blank?
  end
end
