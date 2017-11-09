require 'colorize'

def describe(subject, &tests)
  DescribeBlock.new(subject, tests).run!
end

class DescribeBlock
  attr_reader :subject, :tests
  def initialize(subject, tests)
    @subject = subject
    @tests = tests
    @eager_lets = {}
    @let_values = {}
  end

  def run!
    instance_exec(&tests)
  end

  def it(description, &test)
    reevaluate_all_eager_lets
    Test.new(self, description, test).evaluate!
  end

  def let!(variable_name, &blk)
    @eager_lets[variable_name] = blk
  end

  def reevaluate_all_eager_lets
    @let_values = {}
    @eager_lets.each do |var, blk|
      @let_values[var] = blk.call
    end
  end

  def has_let_variable?(var_name)
    @let_values.has_key?(var_name)
  end

  def get_variable(var_name)
    @let_values[var_name]
  end
end

class Test < Struct.new(:parent, :description, :test)
  def evaluate!
    instance_exec(&test)
    puts "#{parent.subject} #{description}".green
  rescue AssertionError
    puts "FAILED - #{description}".red
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
end

class AssertionError < StandardError
end

class Expectation < Struct.new(:subject)
  def to(condition)
    raise AssertionError unless condition.met?(subject)
  end
end

class Condition < Struct.new(:object)
  def met?(subject)
    raise NotImplementedError
  end
end

class EqualityCondition < Condition
  def met?(subject)
    object == subject
  end
end

class InclusionCondition < Condition
  def met?(subject)
    subject.include?(object)
  end
end
