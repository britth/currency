require './errors.rb'

class Currency
  # class DifferentCurrencyCodeError < StandardError
  # end


  attr_reader :amount, :code
  def initialize(amount:, code:)
    @amount = amount
    @code = code
  end

  def amount
    @amount
  end

  def code
    @code
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

  def *(value)
    if value.is_a?(Float) || value.is_a?(Fixnum)
      @amount = @amount * value
      self
    else
      raise NotAFloatOrFixnumError, "You must pass a float or a fixnum"
    end
  end
end
