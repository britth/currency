require './errors.rb'

class Currency
  @@symbol_to_code = {'$' => :USD, '€' => :USD}
  #attr_reader :amount, :code
  attr_accessor :amount, :code
  #def initialize(amount:, code:)
  def initialize(params = {})
    #@amount = amount
    #@code = code
    @amount = params.fetch(:amount, amount)
    @code = params.fetch(:code, code)
  end

  def amount
    if @amount.class == String
      @amount = @amount[1..@amount.length].to_f
    else
      @amount
    end
  end

  def is_number?(value)
    true if Float(value) rescue false
  end

  def symbol(first_char)
    if not is_number?(first_char)
      @symbol = first_char
    end
  end

  def code
    if @amount.class == String
      @code = @@symbol_to_code[symbol(@amount[0])]
    else
      @code
    end
  end

  def get_code
    if @code.nil?
      raise UnknownCurrencyCodeError, "Currency code is unknown"
    else
      @code
    end
  end

  # def find_code(symbol)
  #   symbol_to_code(symbol)
  # end

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
