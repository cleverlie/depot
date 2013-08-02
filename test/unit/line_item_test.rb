require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  test "increase and decrement actions" do
  
    item = LineItem.create( product_id: 1, cart_id: 1)
    item.quantity = 1
    item.save
    item.increase_quantity!
    assert_equal(2,item.quantity)
    item.decrement_quantity!
    assert_equal(1,item.quantity)
    item.decrement_quantity!
    assert !LineItem.find_by_id(item.id)
  end
end
