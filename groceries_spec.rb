require_relative 'my_rspec'
require_relative 'groceries'
require_relative 'my_rspec/describe_block'
require_relative 'my_rspec/test'
require_relative 'my_rspec/receiver'
require_relative 'my_rspec/stub'
require_relative 'my_rspec/condition'

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

  it "can checkout" do
    allow_any_instance_of(String).to(receive(:upcase).and_return("YOU CHECKED OUT"))

    expect(cart.checkout).to eq("YOU CHECKED OUT")
  end

  it "by default, checkout says nothing" do
     expect(cart.checkout).to eq("")
  end
end
