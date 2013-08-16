def string_compress(string)
  str_array = string.split('')
  str = ""
    letter_count = 1
  str_array.each_with_index do |letter, index|
    if letter == str_array[index+1]
      letter_count = letter_count + 1
    else
      str += (letter + letter_count.to_s)
      letter_count = 1
    end
  end
    if string.length >= str.length
      return str
    else
      return string
    end
end

p string_compress("aaabbcca") == "a3b2c2a1"
p string_compress("zzzzbbzdccc") == "z4b2z1d1c3"
p string_compress("abcd") == "abcd"
