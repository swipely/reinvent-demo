#!/usr/bin/env ruby

class SalesByDayMapper
  def map(line)
    card_token, store, occurred_at, price, authorization_id = line.strip.split(',')
    day = "#{occurred_at[0..9]}"
    key = "#{store},#{day}"
    "#{key}\t#{price}"
  end
end

if __FILE__ == $0
  mapper = SalesByDayMapper.new

  ARGF.each_line do |line|
    puts mapper.map(line)
  end
end
