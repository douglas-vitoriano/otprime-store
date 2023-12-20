class HomeController < ApplicationController
  def index
    @products = Product.all.map { |product| ProductDecorator.new(product) }
    @cart = Cart.find_or_initialize_by(id: session[:cart_id])

    if @cart.new_record?
      @cart.save
      session[:cart_id] = @cart.id
    end
  end
end
