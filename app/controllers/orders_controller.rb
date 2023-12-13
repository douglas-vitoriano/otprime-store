class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to @order, notice: "Pedido criado com sucesso!"
    else
      render :new
    end
  end

  private

  def order_params
    # Adicione os parâmetros necessários para criar um pedido, por exemplo:
    # params.require(:order).permit(:nome, :email, ...)
  end
end
