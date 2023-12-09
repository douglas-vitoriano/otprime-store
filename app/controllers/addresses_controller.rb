class AddressesController < ApplicationController
  def index
    @addresses = Address.all
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      render :new
    end
  end

  private

  def address_params
    params.require(:address).permit(:name, :street, :neighborhood, :number, :address_detail, :zipcode, :city, :state)
  end
end
