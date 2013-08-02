class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    @products = Product.order(:title)
    if session[:counter]
      session[:counter] += 1
    else
      session[:counter] = 1
    end
    @accessed_times = session[:counter]
    @cart = current_cart
  end
end
