class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :add, :remove, :update_item]
  before_action :authenticate_user!

  def show
    @orders = @cart.orders.includes(:product)
    respond_to do |format|
      format.html
      format.turbo_stream { update_cart_stream }
    end
  end

  def create
    @cart = current_user.cart || current_user.build_cart
    @cart.attributes = cart_params

    if @cart.save
      product = Product.find(params[:cart][:id])
      order = @cart.orders.find_or_initialize_by(product: product)
      order.quantity += params[:cart][:quantity].to_i

      order.status = Status.find_by(name: params[:status])
      order.payment_method = PaymentMethod.find_by(name: params[:payment_method])

      if current_user
        order.user = current_user
      end

      if order.save
        flash[:success] = "Produto adicionado ao carrinho com sucesso!"
      else
        flash[:error] = "Erro ao adicionar o produto ao carrinho."
        Rails.logger.error "Order not saved. Errors: #{order.errors.full_messages}"
      end
    else
      flash[:error] = "Erro ao adicionar o produto ao carrinho."
    end

    redirect_to show_items_cart_path(@cart)
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    @cart = current_user.cart || current_user.build_cart

    if quantity.positive? && @product
      current_order = @cart.orders.find_or_initialize_by(product_id: @product.id)

      payment_method_param = params[:payment_method]
      payment_method_sym = payment_method_param.present? ? payment_method_param.to_sym : nil

      current_order.assign_attributes(
        user: current_user,
        quantity: current_order.quantity.to_i + quantity,
        status: Status.find_or_create_by(name: :awaiting_payment),
        payment_method: payment_method_sym,
      )

      if current_order.save
        Rails.logger.info "Order saved: #{current_order.inspect}"
      else
        Rails.logger.error "Order not saved. Errors: #{current_order.errors.full_messages}"
      end
    elsif @product
      @cart.orders.find_by(product_id: @product.id)&.destroy
    end

    @cart.save if @cart.orders.any?

    respond_to do |format|
      format.html {
        redirect_to show_items_cart_url(@cart)
      }
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
      format.turbo_stream { render turbo_stream: turbo_stream.replace("cart", partial: "cart/cart", locals: { cart: @cart }) }
    end
  end

  def remove
    @cart = Cart.find(params[:id])
    orders = @cart.orders
    order_to_remove = orders.find(params[:orders_id])

    order_to_remove.destroy

    respond_to do |format|
      if orders.count >= 1
        format.html { redirect_to show_items_cart_path(@cart), notice: "Item removido do carrinho." }
      else
        format.html { redirect_to root_path, notice: "Item removido do carrinho. Carrinho vazio." }
      end
      format.turbo_stream { remove_item_stream(order_to_remove) }
    end
  end

  private

  def set_cart
    @cart = Cart.find_by(id: params[:id])
  end

  def update_cart_stream
    turbo_stream.replace(
      "cart-frame",
      partial: "carts/cart",
      locals: { cart: @cart },
    )
  end

  def cart_params
    params.require(:cart).permit(:id, :quantity)
  end

  def remove_item_stream(order)
    turbo_stream.remove dom_id(order)
  end
end
