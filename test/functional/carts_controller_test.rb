require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  setup do
    @cart = carts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post :create, cart: {  }
    end

    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should show cart" do
    get :show, id: @cart
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cart
    assert_response :success
  end

  test "should update cart" do
    put :update, id: @cart, cart: {  }
    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should destroy cart" do
    assert_difference('Cart.count', -1) do
      session[:cart_id] = @cart.id
      delete :destroy, id: @cart
    end

    assert_redirected_to store_path
  end
  
  test "cart line item should save price" do
    cart = carts(:one)
    [:ruby, :one, :ruby].each do |product_fixture|
      product = products(product_fixture)
      item = cart.add_product product.id
      assert_equal item.price, product.price,
        "cart line item did not save price" 
    end
  end
  
  def new_cart_with_one_product(product_name)
    cart = Cart.create
    cart.add_product(products(product_name).id).save!
    cart
  end

  test 'cart should create a new line item when adding a new product' do
    cart = new_cart_with_one_product(:rails)
    assert_equal 1, cart.line_items.length
    # Add a new product
    cart.add_product(products(:ruby).id)
    assert_equal 2, cart.line_items.length
  end

  test 'cart should update an existing line item when adding an existing product' do
    cart = new_cart_with_one_product(:rails)
    # Re-add the same product
    cart.add_product(products(:rails).id)
    assert_equal 1, cart.line_items.length
  end
  
  
end
