require './app.rb'
# rubocop:disable Metrics/LineLength: Line is too long
describe Enumerable do
  let(:array) { [1, 2, 3] }
  let(:falsy_array) { [false, false, false] }
  let(:string_array) { %w[hello hey heiyaa] }
  let(:hash_array) { [{ 'a': 1 }, { 'b': 2 }, { 'c': 3 }] }
  let(:threes_array) { [3, 3, 3] }
  let(:increment) { proc { |n| n + 1 } }
  let(:range) { (1..9) }
  describe '#my_each' do
    it "doesn't modify the original array" do
      expect(array.my_each { |n| n + 2 }).to eql(array)
    end

    it 'accepts a range' do
      expect(range.my_each { |n| n + 2 }).to eql(range)
    end

    it 'returns an enumerator if no block is given' do
      expect(array.my_each).to be_an(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it "doesn't modify the original array" do
      expect(array.my_each_with_index { |n| n + 2 }).to eql(array)
    end

    it 'accepts a range' do
      expect(range.my_each_with_index { |n| n + 2 }).to eql(range)
    end

    it 'returns an enumerator if no block is given' do
      expect(array.my_each_with_index).to be_an(Enumerator)
    end
  end

  describe '#my_select' do
    it 'returns a new array' do
      expect(array.my_select { |n| n < 3 }).not_to eql(array)
    end

    it 'returns a new array that its element satisfy the conditions' do
      expect(array.my_select { |n| n < 3 }).to eql([1, 2])
    end

    it 'returns an enumerator when no block is given' do
      expect(array.my_select).to be_an(Enumerator)
    end
  end

  describe '#my_all?' do
    it 'returns true if no argument is given, a block is given and all the elements satisfy the condition' do
      expect(array.my_all? { |n| n < 10 }).to eql(true)
    end

    it "returns false when no argument is given, a block is given and at least one element doesn't satisfy the condition" do
      expect(array.my_all? { |n| n < 3 }).to eql(false)
    end

    it "returns true if no argument is given, no block is given and the array doesn't contain neither nil nor false" do
      expect(array.my_all?).to eql(true)
    end

    it 'returns false if no argument is given, no block is given but at least one of the array elements is false' do
      array << false
      expect(array.my_all?).to eql(false)
    end

    it 'returns false if no argument is given, no block is given but at least one of the array elements is nil' do
      array << nil
      expect(array.my_all?).to eql(false)
    end

    it 'accepts an argument and returns true if all the element inside that array is equal to that argument' do
      expect(falsy_array.my_all?(false)).to eql(true)
    end

    it 'returns true if the argument class is Regexp and all the elements inside the array match that argument' do
      expect(string_array.my_all?(/he/)).to eql(true)
    end

    it 'returns true if the argument is Integer, Float, String, Hash or Array and all the element classes inside that array match the argument' do
      expect(string_array.my_all?(String)).to eql(true)
    end

    it 'returns true if the argument is Integer, Float, String, Hash or Array and all the element classes inside that array match the argument' do
      expect(hash_array.my_all?(Hash)).to eql(true)
    end

    it 'returns true if the argument is Numeric and all the element classes are either Integer, Float or Complex' do
      expect(array.my_all?(Numeric)).to eql(true)
    end

    it 'returns true if the argument class is Integer, Float or String and all the elements inside that array equal the argument' do
      expect(threes_array.my_all?(3)).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'returns true if no argument is given, a block is given and at least one of the elements satisfy the condition' do
      expect(array.my_any? { |n| n == 1 }).to eql(true)
    end

    it "returns false when no argument is given, a block is given and all the elements don't satisfy the condition" do
      expect(array.my_any? { |n| n > 3 }).to eql(false)
    end

    it 'returns true if no argument is given, no block is given and at least one element is not nil neither false' do
      falsy_array << 3
      expect(falsy_array.my_any?).to eql(true)
    end

    it 'returns false if no argument is given, no block is given and all the elements are either nil or false' do
      expect(falsy_array.my_any?).to eql(false)
    end

    it 'accepts an argument and returns true if at least one of the elements inside that array equal the argument' do
      expect(falsy_array.my_any?(false)).to eql(true)
    end

    it 'returns true if the argument class is Regexp and at least one of the elements contains that argument' do
      expect(string_array.my_any?(/lo/)).to eql(true)
    end

    it 'returns true if the argument is Integer, Float, String, Hash or Array and at least one of the element classes inside that array match the argument' do
      falsy_array << "I'm a string"
      expect(falsy_array.my_any?(String)).to eql(true)
    end

    it 'returns true if the argument is Numeric and any of the element classes is either Integer, Float or Complex' do
      falsy_array << 3
      expect(falsy_array.my_any?(Numeric)).to eql(true)
    end

    it 'returns true if the argument class is Integer, Float or String and any of the elements inside that array equal the argument' do
      falsy_array << 3
      expect(falsy_array.my_any?(3)).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'returns true if no argument is given, a block is given and none of the elements satisfy the condition' do
      expect(array.my_none? { |n| n > 10 }).to eql(true)
    end

    it "returns false when no argument is given, a block is given and at least one element doesn't satisfy the condition" do
      expect(array.my_none? { |n| n < 3 }).to eql(false)
    end

    it "returns false if no argument is given, no block is given and the array doesn't contain neither nil nor false" do
      expect(array.my_none?).to eql(false)
    end

    it 'returns false if no argument is given, no block is given but at least one of the array elements is false' do
      array << false
      expect(array.my_none?).to eql(false)
    end

    it 'returns false if no argument is given, no block is given but at least one of the array elements is nil' do
      array << nil
      expect(array.my_none?).to eql(false)
    end

    it 'accepts an argument and returns true if none of the elements inside that array is equal to that argument' do
      expect(falsy_array.my_none?(true)).to eql(true)
    end

    it 'returns true if the argument class is Regexp and none of the elements inside the array match that argument' do
      expect(string_array.my_none?(/tie/)).to eql(true)
    end

    it 'returns true if the argument is Integer, Float, String, Hash or Array but none of the element classes inside that array match the argument' do
      expect(string_array.my_none?(Integer)).to eql(true)
    end

    it 'returns true if the argument is Integer, Float, String, Hash or Array but none of the element classes inside that array match the argument' do
      expect(hash_array.my_none?(Array)).to eql(true)
    end

    it 'returns true if the argument is Numeric but none of the element classes are neither Integer, Float nor Complex' do
      expect(string_array.my_none?(Numeric)).to eql(true)
    end

    it 'returns true if the argument class is Integer, Float or String but none of the elements inside that array equal the argument' do
      expect(threes_array.my_none?(4)).to eql(true)
    end
  end

  describe '#my_count' do
    it 'returns an integer that represents the number of the elements that satisfy the condition when a block is given' do
      expect(array.my_count { |n| n.class == Integer }).to eql(3)
    end

    it 'if an argument is given, the block will be ignored and will return the number of the elements that equal the argument' do
      expect(threes_array.my_count(3) { |n| n.class == String }).to eql(3)
    end

    it 'returns the length of the array or the range if no argument nor block is given' do
      expect(array.my_count).to eql(3)
    end

    it 'returns the number of the elements that equal the argument if only an argument is given' do
      expect(array.my_count(3)).to eql(1)
    end
  end

  describe '#my_map' do
    it 'returns an enumerator when no argument nor block is given' do
      expect(array.my_map).to be_an(Enumerator)
    end

    it 'returns a new array when a block is given' do
      expect(array.my_map { |n| n + 1 }).not_to eql(array)
    end

    it 'returns a new array when a proc is given' do
      expect(array.my_map(increment)).not_to eql(array)
    end

    describe '#my_inject' do
      it 'accepts a block with 2 variables, an accumulator and array element, performs the block code and save the result inside the accumulator' do
        expect(array.my_inject { |sum, elem| sum + elem }).to eql(6)
      end

      it 'works on a range also' do
        expect(range.my_inject { |sum, elem| sum + elem }).to eql(45)
      end

      it 'performs the operation of the symbol if a symbol is only passed as an argument' do
        expect(array.my_inject(:+)).to eql(6)
      end

      it 'accepts an initial accumulator when a value is passed in as an argument' do
        expect(array.my_inject(3) { |sum, elem| sum + elem }).to eql(9)
      end

      it 'accepts an initial value and do the operations of the provided symbol' do
        expect(array.my_inject(3, :+)).to eql(9)
      end
    end
  end
end
# rubocop:enable Metrics/LineLength: Line is too long
