require './errors.rb'

class Currency
  # class DifferentCurrencyCodeError < StandardError
  # end


  attr_reader :amount, :code
  def initialize(amount:, code:)
    @amount = amount
    @code = code
  end

  def ==(other)
    @amount == other.amount && @code == other.code
  end

  def +(other)
    if @code == other.code
      @amount + other.amount
    else
      raise DifferentCurrencyCodeError, "Currency codes do not match"
    end
  end

  def -(other)
    if @code == other.code
      @amount - other.amount
    else
      raise DifferentCurrencyCodeError, "Currency codes do not match"
    end
  end
end
