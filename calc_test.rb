# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'calc'

# Test cases for the integer_string? method.
class IntegerStringTest < Minitest::Test
  def test_simple_string
    assert integer_string?('1')
  end

  def test_multiple_digits
    assert integer_string?('12')
  end

  def test_negative
    assert integer_string?('-1')
  end

  def test_negative_multiple_digits
    assert integer_string?('-12')
  end

  def test_zero_padding
    assert integer_string?('01')
  end

  def test_empty_string
    refute integer_string?('')
  end

  def test_alphabet
    refute integer_string?('abcABC')
  end

  def test_float
    refute integer_string?('1.0')
  end

  def test_alphanumeric
    refute integer_string?('1a')
  end

  def test_hexadecimal
    refute integer_string?('0xdeadbeef')
  end
end

# Test cases for the RPN algorithm.
class RpnTest < Minitest::Test
  def test_addition
    assert_equal %w[1 2 +], to_rpn('1+2')
  end

  def test_subtraction
    assert_equal %w[1 2 -], to_rpn('1-2')
  end

  def test_multiplication
    assert_equal %w[1 2 *], to_rpn('1*2')
  end

  def test_division
    assert_equal %w[1 2 /], to_rpn('1/2')
  end

  def test_addition_addition
    assert_equal %w[1 2 + 3 +], to_rpn('1+2+3')
  end

  def test_addition_subtraction
    assert_equal %w[1 2 + 3 -], to_rpn('1+2-3')
  end

  def test_addition_multiplication
    assert_equal %w[1 2 3 * +], to_rpn('1+2*3')
  end

  def test_addition_division
    assert_equal %w[1 2 3 / +], to_rpn('1+2/3')
  end

  def test_subtraction_addition
    assert_equal %w[1 2 - 3 +], to_rpn('1-2+3')
  end

  def test_subtraction_subtraction
    assert_equal %w[1 2 - 3 -], to_rpn('1-2-3')
  end

  def test_subtraction_multiplication
    assert_equal %w[1 2 3 * -], to_rpn('1-2*3')
  end

  def test_subtraction_division
    assert_equal %w[1 2 3 / -], to_rpn('1-2/3')
  end

  def test_multiplication_multiplication
    assert_equal %w[1 2 * 3 *], to_rpn('1*2*3')
  end

  def test_multiplication_division
    assert_equal %w[1 2 * 3 /], to_rpn('1*2/3')
  end

  def test_division_multiplication
    assert_equal %w[1 2 / 3 *], to_rpn('1/2*3')
  end

  def test_division_division
    assert_equal %w[1 2 / 3 /], to_rpn('1/2/3')
  end

  def test_brackets
    assert_equal %w[1 2 + 3 *], to_rpn('(1+2)*3')
  end

  def test_space
    assert_equal %w[1 2 +], to_rpn('1 + 2')
  end

  def test_multiple_digits
    assert_equal %w[12 3 +], to_rpn('12+3')
  end
end

# Test cases for the calculator.
class CalcTest < Minitest::Test
  def test_addition
    assert_equal 3, calc('1+2')
  end

  def test_subtraction
    assert_equal(-1, calc('1-2'))
  end

  def test_multiplication
    assert_equal 2, calc('1*2')
  end

  def test_division
    assert_equal 2, calc('4/2')
  end

  def test_multiple_digits
    assert_equal 15, calc('12+3')
  end

  def test_operation_priority
    assert_equal 7, calc('1+2*3')
  end

  def test_brackets
    assert_equal 9, calc('(1+2)*3')
  end

  def test_space
    assert_equal 3, calc('1 + 2')
  end

  def test_zero_padding
    assert_equal 3, calc('01+02')
  end
end
