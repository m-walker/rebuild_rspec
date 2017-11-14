class Receiver
  attr_reader :thing_to_stub, :stub, :old_method
  def initialize(thing_to_stub)
    @thing_to_stub = thing_to_stub
  end

  def to(stub)
    @stub = stub
    @old_method = thing_to_stub.instance_method(stub.method_name)
    thing_to_stub.send(:define_method, stub.method_name) { stub.return_value }
  end

  def unstub
    thing_to_stub.send(:define_method, stub.method_name, old_method)
  end
end
