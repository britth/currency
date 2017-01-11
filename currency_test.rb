require './currency.rb'
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
    refute_equal(a + c, 30)
    assert_nil(a + c)
  end

  def test_subtract_currency
    a = Currency.new(amount: 50, code: 'GBP')
    b = Currency.new(amount: 50, code: 'AUD')
    c = Currency.new(amount: 25, code: 'GBP')

    assert_equal(a - c, 25)
    refute_equal(a - b, 0)
    assert_nil(a - b)
  end
end
