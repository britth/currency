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
    a = Currency.new(amount: 22, code: 'USD')
    b = Currency.new(amount: 25, code: 'USD')

    assert_equal(a + b, 47)
    #assert_equal( 1+5, 2)
  end
end
