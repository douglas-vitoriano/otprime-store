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

    if some_condition
      @order.payment_method = "credit_card"
    else
      @order.payment_method = "paypal"
    end

    if @order.save
      redirect_to @order, notice: "Pedido criado com sucesso!"
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, other_allowed_params)
  end
end
