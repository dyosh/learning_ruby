
def stock_picker(arr)
  highest_profit_array = []
  max_profit = 0

  arr.each_with_index do |buy_price, buy_index|
    arr[buy_index+1..-1].each_with_index do |sell_price, sell_index|
      if sell_price - buy_price > max_profit
        max_profit = sell_price - buy_price
        highest_profit_array[0] = buy_index
        highest_profit_array[1] = sell_index + buy_index + 1
      end
    end
  end

  return highest_profit_array
end

# you need to buy before you can sell, so this means that the highest sell day
# cannot be the first day
# puts stock_picker([17,3,6,9,15,8,6,1,10]) #  [1,4]  for a profit of $15-3 = $12

arr = [1,2,3,4,5,6]
# does .each_with_index create a new array in each iteration?
# index_inner always starts at 0.
arr.each_with_index do |value, index|
  arr[index+1..-1].each_with_index do |value_inner, index_inner|
    print value_inner, " "
  end
  puts
end
