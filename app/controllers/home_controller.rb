class HomeController < ApplicationController
  def index
    @products = Product.all.map { |product| ProductDecorator.new(product) }
    @cart = Cart.new(session[:cart])
  end
end
