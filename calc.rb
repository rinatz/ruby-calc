# frozen_string_literal: true

def integer_string?(str)
  str.match?(/\A-?\d+\z/)
end

def to_rpn(formula)
  result = []
  stack = []

  formula.split(%r{([+\-*/()])}).each do |i|
    if integer_string?(i)
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

def calc(formula)
  rpn = to_rpn(formula)

  stack = []
  result = 0

  rpn.each do |i|
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

  result
end

def main
  formula = ARGV[0]
  print calc(formula)
end

main
