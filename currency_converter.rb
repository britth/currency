require './currency.rb'

class CurrencyConverter
  attr_accessor :codes_to_rates
  def initialize(params = {})

    @codes_to_rates = params.fetch(:codes_to_rates, codes_to_rates)
  end

  def codes_to_rates
    @codes_to_rates
  end

  def convert(currency, code)
    if codes_to_rates[code].nil? || currency.code.nil?
      raise UnknownCurrencyCodeError, "Currency code is unknown"
    else
      currency = Currency.new(amount: (currency.amount * codes_to_rates[code]), code: code)
    end
  end

end
