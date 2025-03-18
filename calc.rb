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
    elsif %w[+ -].include?(i)
      result.push(stack.pop) if %w[+ - * /].include?(stack[-1])
      stack.push(i)
    elsif %w[* /].include?(i)
      result.push(stack.pop) if %w[* /].include?(stack[-1])
      stack.push(i)
    elsif i == '('
      stack.push(i)
    elsif i == ')'
      result.push(stack.pop) until stack[-1] == '('
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
    case i
    when '+'
      result = stack.pop
      result = stack.pop + result
      stack.push(result)
    when '-'
      result = stack.pop
      result = stack.pop - result
      stack.push(result)
    when '*'
      result = stack.pop
      result = stack.pop * result
      stack.push(result)
    when '/'
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
