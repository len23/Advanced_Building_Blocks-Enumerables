module Enumerable
  def my_each
    for value in self do
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
    my_each do |element|
      yield(element) && new_arr << element
    end
    new_arr
  end

  def my_all?
    boolean = true
    my_each do |element|
      unless yield(element)
        boolean = false
        break
      end
    end
    boolean
  end

  def my_any?
    boolean = false
    my_each do |element|
      if yield(element)
        boolean = true
        break
      end
    end
    boolean
  end

  def my_none?
    boolean = true
    my_each do |element|
      if yield(element)
        boolean = false
        break
      end
    end
    boolean
  end

  def my_count(argument = nil)
    counter = 0
    if argument.nil?
      my_each do |element|
        yield(element) && counter += 1
      end
    else
      my_each do |element|
        argument == element && counter += 1
      end
    end
    counter
  end

  def my_map
    new_arr = []
    my_each do |element|
      new_arr << yield(element)
    end
    new_arr
  end

  def my_inject(initial = nil)
    accum = 0
    if initial.nil?
      my_each_with_index do |element, index|
        break if index + 1 == length

        if index.zero? accum = yield(element, self[index + 1])
        else
          accum = yield(accum, self[index + 1])
        end
      end
    else
      accum = initial
      my_each do |element|
        accum = yield(accum, element)
      end
    end
    accum
  end

  def my_map_proc(proc1 = nil)
    new_arr = []
    my_each do |element|
      if proc1.nil? new_arr << yield(element)
      else
        new_arr << p1.call(element)
      end
    end
    new_arr
  end
end

def multiply_els(array)
  array.my_inject { |sum, num| sum * num }
end
