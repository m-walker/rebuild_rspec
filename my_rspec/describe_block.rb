class DescribeBlock
  attr_reader :subject, :tests
  def initialize(subject, tests)
    @subject = subject
    @tests = tests
    @eager_lets = {}
    @lazy_lets = {}
    @let_values = {}
  end

  def run!
    instance_exec(&tests)
  end

  def it(description, &test)
    reevaluate_all_eager_lets
    Test.new(self, description, test).evaluate!
  end

  def let(var_name, &blk)
    @lazy_lets[var_name] = blk
  end

  def let!(var_name, &blk)
    @eager_lets[var_name] = blk
  end

  def reevaluate_all_eager_lets
    @eager_lets.keys.each { |var_name| @let_values.delete(var_name) }
    @eager_lets.each do |var, blk|
      @let_values[var] = blk.call
    end
  end

  def has_let_variable?(var_name)
    is_evaluated = @let_values.has_key?(var_name)
    return is_evaluated if is_evaluated

    if @lazy_lets.include?(var_name)
      @let_values[var_name] = @lazy_lets[var_name].call
      true
    else
      false
    end
  end

  def get_variable(var_name)
    @let_values[var_name]
  end
end
