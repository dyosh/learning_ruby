module Enumerable
  def my_each
    if block_given?
      for i in self
        yield i
      end
    else
      return self
    end
  end

  def my_each_with_index
    if block_given?
      for i in 0..self.size-1
        yield self[i], i
      end
    else
      return self
    end
  end

  def my_select
    if block_given?
      selected = []
      for i in self
        selected << i if yield(i)
      end
      return selected
    else
      return self
    end
  end

  def my_all?
    if block_given?
      for i in self
        return false unless yield(i)
      end
      return true
    else
      return self
    end
  end

  def my_none?
    if block_given?
      for i in self
        if yield(i) == true
          return false
        end
      end
      return true
    else
      return self
    end
  end

  def my_count(value=nil)
    count = 0
    for i in self
      if block_given?
        count += 1 if yield(i)
      elsif value != nil
        count += 1 if i == value
      else
        return self
      end
    end
    return count
  end

  def my_map(&my_proc)
    updated_array = []
    if block_given? && my_proc != nil
      self.my_each { |i| updated_array << my_proc.call(i) }
      return updated_array
    else
      return self
    end
  end

  def my_inject(arg=nil)
    if block_given?
      arg != nil ? sum = arg : sum = 0
      self.my_each { |i| sum = yield(sum, i) }
      return sum
    else
      return self
    end
  end
end

def multiple_els(arr)
  return arr.my_inject { |product, i| product * i }
end

arr = [1,2,3,2,4,5,3,3]
# arr.my_each { |num| puts num * 2 }
# arr.my_each_with_index { |num, index| print num }
# a = arr.my_select { |num| num == 3 }
# a = arr.my_all? { |num| num > 0 }
# puts arr.my_none? { |num| num == 3 }
# puts arr.my_count { |num| num == 2 }
# puts arr.my_count(3)
# puts arr.count(3)
# a = arr.my_map { |num| num * 2 }

# puts (5..10).reduce(:+)
# puts (5..10).my_inject { |sum, n| sum + n }

# puts 6 + 12 + 19 + 27 + 36 + 46
# puts (5..10).my_inject(1) { |product, n| product * n }
# puts (5..10).my_inject(1) { |sum, n| sum + n }
# puts (5..10).inject(1) { |product, n| product * n }
# array = [2,4,5]
# puts multiple_els(array)
# a = [1,2,3,4].my_map { |i| i + 3 }
# print a, "\n"

cube = Proc.new { |x| x ** 3 }
a = [3,4,5].my_map(&cube)
puts a

# for num in arr
#   puts num
# end


# def try
#   if block_given?
#     yield
#   else
#     "no block"
#   end
# end
#
# puts try
# puts try { "Hello" }
#
# puts try do "Hello" end

# cube = Proc.new { |x| x ** 3 }
# a = [3,4,5].map!(&cube)
# print a, "\n"
