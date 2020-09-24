require 'pry'
# rubocop:disable Style/For
# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/ModuleLength, Metrics/MethodLength
module Enumerable
  def my_each
    if block_given?
      if is_a?(Range)
        ary = to_a
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
      ary = if is_a?(Range)
              to_a
            else
              self
            end
      for index in 0..ary.length - 1 do
        yield(ary[index], index)
      end
      ary
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

  def my_all?(argument = nil)
    boolean = true
    if argument.nil?
      if block_given?
        my_each do |element|
          unless yield(element)
            boolean = false
            break
          end
        end
      else
        my_each do |element|
          if element.nil? || element == false
            boolean = false
            break
          end
        end
      end
    elsif argument.class == Regexp
      my_each do |element|
        unless argument.match?(element)
          boolean = false
          break
        end
      end
    elsif argument.class == Integer || argument.class == Float
      my_each do |element|
        unless element == argument
          boolean = false
          break
        end
      end
    else
      my_each do |element|
        if element.class != argument
          boolean = false
          break
        end
      end
    end
    boolean
  end

  def my_any?(argument = nil)
    boolean = false
    if argument.nil?
      if block_given?
        my_each do |element|
          if yield(element)
            boolean = true
            break
          end
        end
      else
        my_each do |element|
          unless element.nil? || element == false
            boolean = true
            break
          end
        end
      end
    elsif argument.class == Regexp
      my_each do |element|
        unless argument.match?(element)
          boolean = true
          break
        end
      end
    elsif argument.class == Integer || argument.class == Float
      my_each do |element|
        if element == argument
          boolean = true
          break
        end
      end
    else
      my_each do |element|
        if element.class == argument
          boolean = true
          break
        end
      end
    end
    boolean
  end

  def my_none?(argument = nil)
    boolean = true
    if argument.nil?
      if block_given?
        my_each do |element|
          if yield(element)
            boolean = false
            break
          end
        end
      else
        my_each do |element|
          unless element.nil? || element == false
            boolean = false
            break
          end
        end
      end
    elsif argument.class == Regexp
      my_each do |element|
        if argument.match?(element)
          boolean = false
          break
        end
      end
    elsif argument.class == Integer || argument.class == Float
      my_each do |element|
        if element == argument
          boolean = false
          break
        end
      end
    else
      my_each do |element|
        if element.class == argument
          boolean = false
          break
        end
      end
    end
    boolean
  end

  def my_count(argument = nil)
    counter = 0
    if block_given?
      if argument.nil?
        my_each do |element|
          yield(element) && counter += 1
        end
      else
        my_each do |element|
          argument == element && counter += 1
        end
      end
    elsif argument.nil?
      counter = to_a.length
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

  def my_inject(initial = nil, argument = nil)
    accum = 0
    if initial.nil? && argument.nil?
      my_each_with_index do |element, index|
        break if index + 1 == length

        accum = if index.zero?
                  yield(element, self[index + 1])
                else
                  yield(accum, self[index + 1])
                end
      end
    elsif argument.nil?
      if initial.class == Symbol
        argument = initial
        my_each_with_index do |element, index|
          break if index + 1 == length

          accum = if index.zero?
                    element.public_send argument.to_s, self[index + 1]
                  else
                    accum.public_send argument.to_s, self[index + 1]
                  end
        end
      else
        accum = initial
        my_each do |element|
          accum = yield(accum, element)
        end
      end
    else
      accum = initial
      my_each do |element|
        accum = accum.public_send argument.to_s, element
      end
    end
    accum
  end
end

def multiply_els(array)
  array.my_inject { |sum, num| sum * num }
end

array = [1, 2, 3, 4]

p array.my_inject(:+)

# rubocop:enable Style/For
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/ModuleLength, Metrics/MethodLength
