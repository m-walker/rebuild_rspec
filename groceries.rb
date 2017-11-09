class GroceryItem
  attr_reader :price
  def initialize(price = 0)
    @price = price
  end
end

class Banana < GroceryItem
end

class Cantaloupe < GroceryItem
end

class GroceryCart
  attr_reader :stuff
  def initialize(stuff = [])
    @stuff = stuff
  end

  def pick_out(item)
    raise TypeError unless item.is_a?(GroceryItem)
    stuff << item
  end
end
