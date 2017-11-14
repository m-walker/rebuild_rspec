class Test
  attr_reader :parent, :description, :test, :stubbed_receivers
  def initialize(parent, description, test)
    @parent = parent
    @description = description
    @test = test
    @stubbed_receivers = []
  end

  def evaluate!
    instance_exec(&test)
    puts "#{parent.subject} #{description}".green
  rescue AssertionError
    puts "FAILED - #{description}".red
  ensure
    @stubbed_receivers.each(&:unstub)
  end

  def expect(subject)
    Expectation.new(subject)
  end

  def eq(object)
     EqualityCondition.new(object)
  end

  def include?(object)
    InclusionCondition.new(object)
  end

  def method_missing(m, *args)
    if parent.has_let_variable?(m)
      parent.get_variable(m)
    else
      super
    end
  end

  def allow_any_instance_of(thing_to_stub)
    stub = Receiver.new(thing_to_stub)
    @stubbed_receivers << stub
    stub
  end

  def receive(method_name)
    Stub.new(method_name)
  end
end
