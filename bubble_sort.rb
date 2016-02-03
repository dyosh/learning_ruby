
def bubble_sort(num_array)
  swapped = true
  while swapped
    swapped = false
    for i in 0..num_array.size-2
      if (num_array[i] > num_array[i+1])
        num_array[i], num_array[i+1] = num_array[i+1], num_array[i]
        swapped = true
      end
    end
  end
  return num_array
end

def bubble_sort_by(items, &block)
  swapped = true
  while swapped
    swapped = false
    for i in 0..items.size-2
      if block.call(items[i], items[i+1]) > 0
        items[i], items[i+1] = items[i+1], items[i]
        swapped = true
      end
    end
  end
  return items
end

# print bubble_sort([4,3,78,2,0,2]), "\n"

a = bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end

print a, "\n"
