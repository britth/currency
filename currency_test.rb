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
    assert_raises(UnknownCurrencyCodeError, "Currency code is unknown") do
      c.get_code
    end
  end

  def test_converter_object_can_take_hash
    a = CurrencyConverter.new(codes_to_rates: {USD: 1.0, EUR: 0.74})

    assert_equal(a.codes_to_rates, {USD: 1.0, EUR: 0.74})
  end

  def test_convert_currency_object_to_same_code
    a = Currency.new(amount: 10.00, code: :USD)
    b = CurrencyConverter.new(codes_to_rates: {USD: 1.0, EUR: 0.74})
    assert_equal(a, b.convert(a, :USD))
  end

  def test_convert_currency_object_to_different_code
    a = Currency.new(amount: 10.00, code: :USD)
    b = CurrencyConverter.new(codes_to_rates: {USD: 1.0, EUR: 0.74})
    c = b.convert(a, :EUR)
    refute_equal(a, c)
    assert_equal(a.amount * 0.74, c.amount)
    assert_equal(c.code, :EUR)
  end

  def test_currency_converter_can_take_hash_of_three
    a = CurrencyConverter.new(codes_to_rates: {USD: 1.0, EUR: 0.74, JPY: 120.0})
    refute_nil(a)
    assert(a.codes_to_rates, {USD: 1.0, EUR: 0.74, JPY: 120.0})
  end

  def test_currency_converter_can_convert_in_any_code_it_knows
    a = Currency.new(amount: '$1.00')
    b = CurrencyConverter.new(codes_to_rates: {USD: 1.0, EUR: 0.74, JPY: 120.0})
    c = b.convert(a, :EUR)
    d = b.convert(a, :JPY)
    e = Currency.new(amount: 0.74, code: :EUR)
    f = Currency.new(amount: 120, code: :JPY)

    assert_equal(c.amount, a.amount * 0.74)
    assert_equal(d.amount, a.amount * 120.0)
    assert_equal(c, e)
    assert_equal(d, f)

  end

  def test_currency_coverter_throws_error_for_unknown_code
    a = Currency.new(amount: '$1.00')
    b = CurrencyConverter.new(codes_to_rates: {USD: 1.0, EUR: 0.74, JPY: 120.0})

    assert_raises(UnknownCurrencyCodeError, "Currency code is unknown") do
      b.convert(a, :GBP)
    end
  end

end
