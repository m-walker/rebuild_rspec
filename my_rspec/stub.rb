class Stub
  attr_reader :method_name, :return_value
  def initialize(method_name)
    @method_name = method_name
  end

  def and_return(return_value)
    @return_value = return_value
    self
  end
end
