def replace_space(string)
  string.split(" ").join("%20")
end

p replace_space("snarf snarf") == "snarf%20snarf"
p replace_space(" dousche rocket  ") == "dousche%20rocket"
