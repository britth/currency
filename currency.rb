class Currency
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
    end
  end

  def -(other)
    if @code == other.code
      @amount - other.amount
    end
  end
end
