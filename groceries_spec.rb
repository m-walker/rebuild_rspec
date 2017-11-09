require_relative 'my_rspec'
require_relative 'groceries'

describe GroceryCart do
  let!(:cart) { GroceryCart.new }

  it "can pick out a new item that is a GroceryItem" do
    banana = Banana.new
    cart.pick_out(banana)

    expect(cart.stuff[0]).to eq(banana)
    expect(cart.stuff).to include?(banana)
  end

  it "starts out empty" do
    expect(cart.stuff.empty?).to eq(true)
  end
end
