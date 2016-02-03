class String
  def is_upper?
    self == self.upcase
  end

  def is_letter?
    self == self[/[a-zA-z]+/]
  end
end

def caesar_cipher(str, shift)
  str_array = str.split("")
  str_array.collect! do |letter|
    if letter == " "
      letter = letter
    elsif !(letter.is_letter?)
      ord_value = shift_char(letter, shift, false)
      letter = ord_value.chr
    elsif letter.is_upper?
      ord_value = shift_char(letter.downcase, shift)
      letter = ord_value.chr.upcase
    else
      ord_value = shift_char(letter, shift)
      letter = ord_value.chr
    end
  end
  return str_array.join
end

def shift_char(char, shift, is_letter=true)
  if is_letter
    return char.ord + shift > 122 ? (char.ord + shift + 96 - 122) : (char.ord + shift)
  else
    return char.ord + shift
  end
end

puts caesar_cipher("What a string!", 5)
# caesar_cipher("What a string!", 5)
# "Bmfy f xywnsl!"
