class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :add, :remove, :update_item]

  def show
    @cart = Cart.find(params[:id])
    @orders = @cart.orders.includes(:product)
  end

  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      redirect_to @cart
    else
      render :new
    end
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    @cart ||= Cart.find_or_create_by(user: current_user)

    if quantity.positive? && @product
      current_order = @cart.orders.find_or_initialize_by(product_id: @product.id)
      current_order.user ||= current_user if current_user.present?
      current_order.user_id ||= current_user&.id
      current_order.update(quantity: quantity)
    elsif @product
      @cart.orders.find_by(product_id: @product.id)&.destroy
    end

    respond_to do |format|
      format.html { redirect_to cart_path(@cart) }
      format.turbo_stream { update_cart_stream }
    end
  end

  def update_item
    @product = Product.find_by(id: params[:product_id])
    quantity = params[:quantity].to_i

    if quantity.positive? && @product
      current_order = @cart.orders.find_or_initialize_by(product_id: @product.id)
      current_order.update(quantity: quantity)
    elsif @product
      @cart.orders.find_by(product_id: @product.id)&.destroy
    end

    respond_to do |format|
      format.turbo_stream { update_cart_stream }
    end
  end

  def remove
    @cart.orders.find_by(id: params[:id])&.destroy

    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: "Item removido do carrinho com sucesso!" }
      format.turbo_stream { update_cart_stream }
    end
  end

  private

  def set_cart
    @cart = Cart.find_by(id: params[:id])
  end

  def update_cart_stream
    render turbo_stream: [
      turbo_stream.replace("cart", partial: "cart/cart", locals: { cart: @cart }),
      turbo_stream.replace(@product),
    ]
  end

  def cart_params
    params.require(:cart).permit(:user_id)
  end
end
