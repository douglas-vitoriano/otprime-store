class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(:status, :payment_method)
  end

  def new
    @order = Order.new
    @products = Product.all
    @user = current_user
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
    params.require(:order).permit(:quantity)
  end
end
