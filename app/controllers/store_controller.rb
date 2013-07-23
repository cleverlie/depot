class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    if session[:counter]
      session[:counter] += 1
    else
      session[:counter] = 1
    end
    @accessed_times = session[:counter]
  end
end
