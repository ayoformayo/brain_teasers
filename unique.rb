def unique_char(string)
  str_array = string.split("")
  p str_array.uniq
  if str_array == str_array.uniq
    return true
  else
    return false
   end 
end

p unique_char("abcdefgh") == true
p unique_char('aabcd') == false
