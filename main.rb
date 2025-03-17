# frozen_string_literal: true

def integer?(str)
  !Integer(str).nil? rescue false
end

def to_rpn(formula)
  result = []
  stack = []

  formula.split(/([\+\-\*\/\(\)])/).each do |i|
    if integer?(i)
      result.push(i)
    elsif i == '+' || i == '-'
      if stack[-1] == '+' || stack[-1] == '-' || stack[-1] == '*' || stack[-1] == '/'
        result.push(stack.pop)
      end
      stack.push(i)
    elsif i == '*' || i == '/'
      if stack[-1] == '*' || stack[-1] == '/'
        result.push(stack.pop)
      end
      stack.push(i)
    elsif i == '('
      stack.push(i)
    elsif i == ')'
      while stack[-1] != '('
        result.push(stack.pop)
      end
      stack.pop
    end
  end

  result.push(stack.pop) until stack.empty?

  result
end

def main
  formula = to_rpn(ARGV[0])

  stack = []
  result = 0

  formula.each do |i|
    if i == '+'
      result = stack.pop
      result = stack.pop + result
      stack.push(result)
    elsif i == '-'
      result = stack.pop
      result = stack.pop - result
      stack.push(result)
    elsif i == '*'
      result = stack.pop
      result = stack.pop * result
      stack.push(result)
    elsif i == '/'
      result = stack.pop
      result = stack.pop / result
      stack.push(result)
    else
      stack.push(i.to_i)
    end
  end

  print result
end

main
