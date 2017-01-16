require './currency_converter.rb'

class CurrencyTrader
  attr_accessor :cc_one, :cc_two, :currency
  def initialize(params = {})
    @cc_one = params.fetch(:cc_one, cc_one)
    @cc_two = params.fetch(:cc_two, cc_two)
    @currency = params.fetch(:currency, currency)
  end

  def cc_one
    @cc_one
  end

  def cc_two
    @cc_two
  end

  def currency
    @currency
  end

  def best_investment
    a = cc_one.codes_to_rates
    b = cc_two.codes_to_rates
    a_adj = a.each_with_object({}){|(k, v), o| o[k.to_sym] = v * currency.amount}
    best = a_adj.each{|k, v| (a_adj[k] = v / b.select{|x, y| x == k}.map{|x, y| y}.first)}
    best.sort_by {|_key, value| -value}.to_h.first.first
  end

end
