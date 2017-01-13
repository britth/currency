require './currency.rb'

class CurrencyConverter
  #attr_reader :amount, :code
  attr_accessor :codes_to_rates#, :code
  def initialize(params = {})

    @codes_to_rates = params.fetch(:codes_to_rates, codes_to_rates)
  #  @code = params.fetch(:code, code)
  end

  def codes_to_rates
    @codes_to_rates
  end

  def convert(currency, code)
    currency.amount * codes_to_rates[code]
  end

end
