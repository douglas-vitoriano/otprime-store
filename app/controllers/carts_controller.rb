class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :add, :remove]

  def show
    @address ||= Address.new
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    @cart ||= Cart.find_or_create_by(user: current_user)

    if quantity.positive?
      current_orderable = @cart.orderables.find_or_initialize_by(product_id: @product&.id)
      current_orderable.update(quantity: quantity)
    else
      @cart.orderables.find_by(product_id: @product&.id)&.destroy
    end

    respond_to do |format|
      format.html { redirect_to cart_path(@cart) }
      format.turbo_stream { update_cart_stream }
    end
  end

  def update_item
    @cart ||= Cart.find_by(id: params[:id])
    @product = Product.find_by(id: params[:product_id])
    quantity = params[:quantity].to_i

    if quantity.positive?
      current_orderable = @cart.orderables.find_or_initialize_by(product_id: @product&.id)
      current_orderable.update(quantity: quantity)
    else
      @cart.orderables.find_by(product_id: @product&.id)&.destroy
    end

    # respond_to do |format|
    #   format.turbo_stream { update_cart_stream }
    # end
  end

  def remove
    Orderable.find_by(id: params[:id])&.destroy

    respond_to do |format|
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
end
