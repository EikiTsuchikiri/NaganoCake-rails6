class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_address, only: [:edit, :update, :destroy]

  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def create
    @addresses = current_customer.addresses
    # @address = @addresses.new(address_params)
    # こう書くと、save出来なかった時に、@addressesの最後に空レコードが入り、エラーになる。
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save ? (redirect_to addresses_path) : (render :index)
  end

  def edit
  end

  def update
    @address.update(address_params) ? (redirect_to addresses_path) : (render :edit)
  end

  def destroy
    @address.destroy
    redirect_to addresses_path
  end

  private

  def ensure_address
    @addresses = current_customer.addresses
    @address = @addresses.find_by(id: params[:id])
    redirect_to addresses_path unless @address
  end

  def address_params
    params.require(:address).permit(:postal_code, :destination, :name)
  end
end
