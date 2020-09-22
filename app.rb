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

  def my_inject(initial=self[0])
    accum = initial
    self.my_each do |element|
      accum = yield(accum,element)
    end
    accum
  end
end
