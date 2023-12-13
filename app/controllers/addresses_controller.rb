class AddressesController < ApplicationController
  def index
    @addresses = current_user.addresses
    @addresses = Address.all

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @address = current_user.addresses.new
  end

  def show
    @address = current_user.addresses.find(params[:id])
    render action: :edit
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      flash[:notice] = "Endereço cadastrado com sucesso!"
      redirect_to addresses_path
    else
      render action: :index
    end
  end

  def update
    @address = current_user.addresses.find_by(params[:id])
    if @address.update
      flash[:notice] = "Endereço atualizado com sucesso!"
      redirect_to addresses_path
    else
      @addresses = current_user.addresses
      render addresses_path
    end
  end

  def destroy
    @address = current_user.addresses.find(params[:id])
    if @address.destroy
      flash[:notice] = "Endereço excluído com sucesso!"
    else
      flash[:alert] = "Erro ao excluir o endereço."
    end
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(
      :name, :street, :neighborhood, :number, :address_detail, :zipcode, :city, :state
    )
  end

  #   def set_address
  #     @address = current_user.addresses.find(params[:id])
  #   end
end
