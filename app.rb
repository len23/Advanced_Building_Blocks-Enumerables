module Enumerable
  def my_each
    if block_given?
      if self.kind_of?(Range)
        ary = self.to_a
        for value in ary do
          yield(value)
        end
      else
        for value in self do
          yield(value)
        end
      end
    else
      to_enum :my_each
    end
  end

  def my_each_with_index
    if block_given?
      if self.kind_of?(Range)
        ary = self.to_a
        for index in 0..ary.length - 1 do
          yield(ary[index], index)
        end
        ary
      else
        ary = self
        for index in 0..ary.length - 1 do
          yield(ary[index], index)
        end
        ary
      end
    else
      to_enum :my_each_with_index
    end
  end

  def my_select
    if block_given?
      new_arr = []
      my_each do |element|
        yield(element) && new_arr << element
      end
      new_arr
    else
      to_enum :my_select
    end
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

  def my_map(proc1 = nil)
    if block_given?
      new_arr = []
      my_each do |element|
        new_arr << if proc1.nil?
                    yield(element)
                  else
                    proc1.call(element)
                  end
      end
      new_arr
    else
      to_enum :my_map
    end
  end

  def my_inject(initial = nil)
    accum = 0
    if initial.nil?
      my_each_with_index do |element, index|
        break if index + 1 == length

        accum = if index.zero?
                  yield(element, self[index + 1])
                else
                  yield(accum, self[index + 1])
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
end

def multiply_els(array)
  array.my_inject { |sum, num| sum * num }
end

array = [1, 2, 3, 4]

# p array.each

p "Hello there".my_each_with_index{ |x| x }
