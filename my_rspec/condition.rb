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
