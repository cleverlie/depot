class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
  
  
  
  private
  
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
  
  protected
    
    def authorize
      unless request.format == Mime::HTML
        authenticate_or_request_with_http_basic do |n, p|
          user = User.find_by_name(n)
          if user and user.authenticate(p)
            session[:user_id] = user.id
          end
        end
      else
        unless User.find_by_id(session[:user_id])
          redirect_to login_url, notice: "Please log in" 
        end
      end
    end

    
end
