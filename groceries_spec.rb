require_relative 'my_rspec'
require_relative 'groceries'

describe GroceryCart do
  it "can pick out a new item that is a GroceryItem" do
    cart = GroceryCart.new
    banana = Banana.new
    cart.pick_out(banana)
    expect(cart[0]).to eq(banana)
  end
end
