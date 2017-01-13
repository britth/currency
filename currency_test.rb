#require './currency.rb'
require './currency_converter.rb'
require 'minitest/pride'
require 'minitest/autorun'

class CurrencyTest < Minitest::Test
  def test_currency_creation
    Currency.new(amount: 34, code: 'USD')
  end

  def test_equal_currencies
    a = Currency.new(amount: 34, code: 'USD')
    b = Currency.new(amount: 34, code: 'USD')
    assert a == b
    c = Currency.new(amount: 34, code: 'EUR')
    refute a == c
  end

  def test_add_currency
    a = Currency.new(amount: 25, code: 'USD')
    b = Currency.new(amount: 25, code: 'USD')
    c = Currency.new(amount: 5, code: 'EUR')
    assert_equal(a + b, 50)
    assert_raises(DifferentCurrencyCodeError, "Currency codes do not match") do
      a+c
    end
  end

  def test_subtract_currency
    a = Currency.new(amount: 50, code: 'GBP')
    b = Currency.new(amount: 50, code: 'AUD')
    c = Currency.new(amount: 25, code: 'GBP')

    assert_equal(a - c, 25)
    assert_raises(DifferentCurrencyCodeError, "Currency codes do not match") do
      a+b
    end
  end

  def test_can_multiply_by_float_or_fixnum
    a = Currency.new(amount: 5, code: 'NZD')
    b = a.amount
    c = a * 5
    assert_equal(a, c)
    refute_equal(a.amount, b)
    assert_raises(NotAFloatOrFixnumError, "You must pass a float or a fixnum") do
      a*'hello'
    end
  end

  def test_understanding_symbols
    a = Currency.new(amount: "$5.00")
    b = Currency.new(amount: 10.00, code: 'AUD')
    c = Currency.new(amount: "₹44")
    assert_equal(a.amount, 5)
    assert_equal(a.code, 'USD')
    assert_equal(b.amount, 10)
    assert_equal(b.code, 'AUD')
    assert_nil(c.code)
    assert_raises(NoKnownCurrencyError, "Currency code is unknown") do
      c.get_code
    end
  end

  def test_converter_object_can_take_hash
    a = CurrencyConverter.new(codes_to_rates: {USD: 1.0, EUR: 0.74})

    assert_equal(a.codes_to_rates, {USD: 1.0, EUR: 0.74})
  end

  def test_convert_currency_object_to_same_code
    a = Currency.new(amount: 10, code: 'USD')
    b = CurrencyConverter.new(codes_to_rates: {USD: 1.0, EUR: 0.74})
    assert_equal(a.amount, b.convert(a, :EUR))
  end

end
