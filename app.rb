module Enumerable
  def my_each
    # your code here
   ary = self
   for value in ary do
    yield(value)
   end
  end

  def my_each_with_index
    ary = self
    for index in 0..ary.length-1 do
      yield(ary[index],index)
    end
  end

  def my_select
    new_arr=[]
    self.my_each do |element| 
      if yield(element)
        new_arr << element
      end  
    end
    new_arr
  end
end

arr_nums = [1,2,3,3,5]

p arr_nums.my_select {|number| number == 3}

# arr_nums.my_each_with_index do |value,index|
#   puts "The index #{index} has the value #{value}"
# end

# arr_nums.my_each do |element|
#   p element
# end