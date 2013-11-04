#!/usr/bin/env ruby

class SalesByHourReducer
  def reduce(line)
    key, vals = line.split("\t")
    key_parts = key.split(',')
    store = key_parts[0]
    hour = key_parts[1]
    vals = vals.split(',')
    sales = vals[0].to_i

    @prev_key ||= key
    @total_sales ||= 0

    if @prev_key != key
      results = current_results
      @prev_key = key
      @total_sales = 0
    end

    @total_sales += sales

    results
  end

  def current_results
    "#{@prev_key},#{@total_sales}"
  end
end

if __FILE__ == $0
  reducer = SalesByHourReducer.new

  ARGF.each_line do |line|
    if line = reducer.reduce(line.strip)
      puts line
    end
  end

  puts reducer.current_results
end
