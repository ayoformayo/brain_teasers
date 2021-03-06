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

  def delete_one_if
    deleted = []
    self.each_with_index do |r, index|
      result = yield r
      if result && !deleted.include?(r)
        deleted << r
        self[index] = nil
      end
    end
    return self.compact!.sort!
  end
end
# ['snarf', 'sneeze', 'tickle', 'tottle', 'do'].my_group { |i| i[0] }
# p (1..10).my_group { |i| i%3 }  == {0=>[3, 6,9], 1=>[1, 4,7,10], 2=>[2, 5,8]}


arr = [1,2,2,3,3,1]

p arr.delete_one_if{|i| i % 2 == 0} == [1,2,3,1,3].sort
