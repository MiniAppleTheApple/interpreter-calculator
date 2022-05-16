# this version is written in May 12, 2022
require_relative "utils"
require_relative "token"
require_relative "expression"

include TextMatch

def add_token(list, value, type)
  list.push(Token.new(value, type))
end

def left_right(root, type, number)
  if operation_order(type) > operation_order(root.type)
    [root.left, Operator.new(type, root.right, number)]
  else
    [Operator.new(type, root.right, number), root.left]
  end
end

def parse(tokens)
  root = nil
  until tokens.empty?
    if root == nil
      first = Digit.new tokens.shift.value.to_i
      type = tokens.shift.value
      second = Digit.new tokens.shift.value.to_i
      root = Operator.new type, first, second
      next
    end

    type = tokens.shift.value
    number = Digit.new tokens.shift.value.to_i
    left, right = left_right(root, type, number)
    root = Operator.new root.type, left, right 
  end
  root
end

def lexer(char_stack)
  current = ""
  tokens = []
  until char_stack.empty?
    current = char_stack.shift
    if current.match? DIGIT
      identifier = current
      loop do
        current = char_stack.shift
        break unless current.match? DIGIT
        break if current == 0
        identifier += current
      end
      add_token(tokens, identifier, :digit)
    end
    
    if current.match? OPERATOR
      add_token(tokens, current, :operator)
    end
  end
  tokens
end

def main

  def read_input
    gets.chomp
  end

  def welcome_message
    puts "Welcome to simple calculator"
    print "What is your problem: "
  end

  welcome_message

  tokens = lexer read_input.chars.concat([""])
  syntax_tree = parse tokens
  puts syntax_tree.value
end

main if __FILE__ == $0