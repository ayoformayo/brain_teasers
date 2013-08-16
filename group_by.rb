module Enumerable
def my_group
  new_hash = {}
  self.each  do | i|
    result = yield i
    if new_hash[result]
      new_hash[result] << i
    else
      new_hash[result] = []
      new_hash[result] << i
    end
  end
  p new_hash
  end
end
['snarf', 'sneeze', 'tickle', 'tottle', 'do'].my_group { |i| i[0] }
p (1..10).my_group { |i| i%3 }  == {0=>[3, 6], 1=>[1, 4], 2=>[2, 5]}
