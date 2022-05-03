class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_customer, only: [:show, :edit, :update]

  def index
    @customers = Customer.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    @customer.update(customer_params) ? (redirect_to admin_customer_path(@customer)) : (render :edit)
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number, :is_active)
  end

  def ensure_customer
    @customer = Customer.find(params[:id])
  end
end
