require 'pry'

module Enumerable
  def my_each
    ary = self
    for value in ary do
      yield(value)
    end
  end

  def my_each_with_index
    ary = self
    for index in 0..ary.length - 1 do
      yield(ary[index], index)
    end
  end

  def my_select
    new_arr = []
    self.my_each do |element|
      if yield(element)
        new_arr << element
      end
    end
    new_arr
  end

  def my_all?
    boolean = true
    self.my_each do |element|
      unless yield(element)
        boolean = false
        break
      end
    end
    boolean
  end

  def my_any?
    boolean = false
    self.my_each do |element|
      binding.pry
      if yield(element)
        boolean = true
        break
      end
    end
    boolean
  end

  def my_none?
    boolean = true
    self.my_each do |element| 
      if yield(element)
        boolean = false
        break
      end
    end
    boolean
  end

  def my_count
    counter = 0
    self.my_each do |element| 
      if yield(element)
        counter += 1
      end
    end
    counter
  end

  def my_map
    new_arr = []
    self.my_each do |element|
        new_arr << yield(element)
    end
    new_arr
  end

  def my_inject(initial = nil)
    accum = 0
    if initial === nil
      initial = self[0]
      self.my_each_with_index do |element, index|
        if index + 1 == self.length
          break
        else
          if index == 0
            accum = yield(element, self[index + 1])
          else
            accum = yield(accum, self[index + 1])
          end
        end
      end
    else
      accum = initial
      self.my_each do |element|
        accum = yield(accum, element)
    end
  end
    accum
  end

  def my_map_proc(p1)
    new_arr = []
    self.my_each do |element|
      new_arr << p1.call(element)
    end
    new_arr
  end
end

def multiply_els(array)
  array.my_inject { |sum, num| sum * num }
end

array = [1, 2, 3, 4]

proc_argument = Proc.new { |number| number + 3 }

p array.my_map_proc(proc_argument)
