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

  def my_inject (symbol)
    accum = first
    my_each_with_index do |element,index|
      p length
    end
  end
end

p (5..10).my_inject(:+)