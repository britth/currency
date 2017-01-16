require './currency_converter.rb'

class CurrencyTrader
  attr_accessor :cc_one, :cc_two, :currency
  #def initialize(amount:, code:)
  def initialize(params = {})
    #@amount = amount
    #@code = code
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
    #cc_one[]
    a = cc_one.codes_to_rates
    b = cc_two.codes_to_rates
    # a_adj = a.each do |k, v|
    #   a[k] = v * currency.amount
    # end
    #a_adj = a.each{|k, v| a[k] = v * currency.amount}
    a_adj = a.each_with_object({}){|(k, v), o| o[k.to_sym] = v * currency.amount}

    #({}){|(k,v),o| o[k.to_sym]=v * 5 }
    #a_adj = a.each{|k, v| {k=>v* currency.amount}}

    # b_adj = b.each do |k, v|
    #   b[k] = v * currency.amount
    # end
    #b_adj = b.each{|k, v| b[k] = v * currency.amount}
    # best = a_adj.each do |k, v|
    #   a_adj[k] = b_adj.select{|x, y| x == k}.map{|x, y| y}.first/v
    # end
    # best = a_adj.each{|k, v| a_adj[k] = b_adj.select{|x, y| x == k}.map{|x, y| y}.first/v}
    # best.sort_by {|_key, value| -value}.to_h.first.first
    # best

    best = a_adj.each{|k, v| (a_adj[k] = v / b.select{|x, y| x == k}.map{|x, y| y}.first)}
    best.sort_by {|_key, value| -value}.to_h.first.first
    # best = a_adj.map{|k, v| v}
    #a.map{|k, v| {k=>v* currency.amount}}
    #a_adj
    #a
    #b_adj.merge(a_adj) { |key, old_value, new_value| old_value - new_value }
  end

end
