require '/currency.rb'
require 'minitest/pride'
require 'minitest/autorun'

class CurrencyTest < Minitest::Test
  def test_currency_creation
    Currency.new(amount: 34, code: 'USD')
  end
end
