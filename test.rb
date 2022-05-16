require "minitest/autorun"

require_relative "main"
require_relative "token"
require_relative "utils"
require_relative "expression"

class LexerTest < Minitest::Test
  def setup
    @first = "10 + 10"
    @second = "20 + 3 - 8 / 10 * 9"
  end

  def test_two_digit_one_operator_type
    tokens = lexer(@first.chars.concat([""]))
    tokens_type = tokens.map {|e| e.type}
    assert_equal tokens_type, [:digit, :operator, :digit]
  end

  def test_many_digit_type
    tokens = lexer(@second.chars.concat([""]))
    tokens_type = tokens.map {|e| e.type}
    assert_equal tokens_type, [:digit, :operator, :digit, :operator, :digit, :operator, :digit, :operator, :digit]
  end

  def test_two_digit_one_operator_value
	  tokens = lexer(@first.chars.concat([""]))
    tokens_value = tokens.map {|e| e.value}
    assert_equal tokens_value, ["10", "+", "10"]
  end

  def test_many_digit_value
    tokens = lexer(@second.chars.concat([""]))
    tokens_value = tokens.map {|e| e.value}
    assert_equal tokens_value, ["20", "+", "3", "-", "8", "/", "10", "*", "9"]
  end
end

class OperatorTest < Minitest::Test
  def test_simple_equation
    operator = Operator.new("+", Digit.new(10), Digit.new(20))
    assert_equal operator.value, 30
  end

  def test_three_digit
    x = Operator.new("*", Digit.new(10), Digit.new(20))
    operator = Operator.new("+", x, Digit.new(30))
    assert_equal operator.value, 230
  end
end

class OperationUtilsTest < MiniTest::Test
  def test_operation_order
    assert_operator operation_order("+"), :<, operation_order("*") 
  end
end

class ParseTest < MiniTest::Test
  def test_parse
    tree = parse [Token.new("1", :digit), Token.new("+", :operator), Token.new("1", :digit), Token.new("*", :operator), Token.new("2", :digit)]
    assert_equal tree.value, 3
  end
end