class Digit
	
  attr_accessor :value  
  def initialize(value)
  	@value = value
  end

  def calculate
  	self
  end
end

class Operator
  attr_accessor :type, :left, :right
  def initialize(type, left, right)
  	@type = type
  	@left = left
  	@right = right
  end

  def calculate
    case @type
    when "+"
  	  Digit.new @left.value + @right.value
    when "-"
  	  Digit.new @left.value - @right.value
    when "*"
  	  Digit.new @left.value * @right.value
    when "/"
  	  Digit.new @left.value / @right.value
    end
  end

  def value
  	calculate.value
  end

end

def operation_order(operation)
  case operation
  when "+", "-"
    0
  when "*", "/"
    1
  end
end

def sorted_operation(x, y)
  if operation_order(x) > operation_order(y)
    [x, y]
  elsif operation_order(y) > operation_order(x)
    [y, x]
  end
end
