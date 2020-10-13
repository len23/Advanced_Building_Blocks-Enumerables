require './app.rb'
# rubocop:disable Layout/LineLength
describe Enumerable do
  let(:array) { [1, 2, 3] }
  let(:truthy_array) { [true, true, true] }
  let(:string_array) { %w[hello hey heiyaa] }
  let(:hash_array) { [{ 'a': 1 }, { 'b': 2 }, { 'c': 3 }] }
  let(:threes_array) { [3, 3, 3] }
  describe '#my_each' do
    it "doesn't modify the original array" do
      expect(array.my_each { |n| n + 2 }).to eql array
    end

    it 'accepts a range' do
      expect((1..9).my_each { |n| n + 2 }).to eql(1..9)
    end

    it 'returns an enumerator if no block is given' do
      expect(array.my_each).to be_an Enumerator
    end
  end

  describe '#my_each_with_index' do
    it "doesn't modify the original array" do
      expect(array.my_each_with_index { |n| n + 2 }).to eql array
    end

    it 'accepts a range' do
      expect((1..9).my_each_with_index { |n| n + 2 }).to eql(1..9)
    end

    it 'returns an enumerator if no block is given' do
      expect(array.my_each_with_index).to be_an Enumerator
    end
  end

  describe '#my_select' do
    it 'returns a new array' do
      expect(array.my_select { |n| n < 3 }).not_to eql array
    end

    it 'returns a new array that its element satisfy the conditions' do
      expect(array.my_select { |n| n < 3 }).to eql [1, 2]
    end

    it 'returns an enumerator when no block is given' do
      expect(array.my_select).to be_an Enumerator
    end
  end

  describe '#my_all?' do
    it 'returns true if no argument is given, a block is given and all the elements satisfy the condition' do
      expect(array.my_all? { |n| n < 10 }).to eql true
    end

    it "returns false when no argument is given, a block is given and at least one element doesn't satisfy the condition" do
      expect(array.my_all? { |n| n < 3 }).to eql false
    end

    it "returns true if no argument is given, no block is given and the array doesn't contain neither nil nor false" do
      expect(array.my_all?).to eql true
    end

    it 'returns false if no argument is given, no block is given but at least one of the array elements is false' do
      array << false
      expect(array.my_all?).to eql false
    end

    it 'returns false if no argument is given, no block is given but at least one of the array elements is nil' do
      array << nil
      expect(array.my_all?).to eql false
    end

    it 'accepts an argument and returns true if all the element inside that array is equal to that argument' do
      expect(truthy_array.my_all?(true)).to eql true
    end

    it 'returns true if the argument class is Regexp and all the elements inside the array match that argument' do
      expect(string_array.my_all?(/he/)).to eql true
    end

    it 'returns true if the argument is Integer, Float, String, Hash or Array and all the element classes inside that array match the argument' do
      expect(string_array.my_all?(String)).to eql true
    end

    it 'returns true if the argument is Integer, Float, String, Hash or Array and all the element classes inside that array match the argument' do
      expect(hash_array.my_all?(Hash)).to eql true
    end

    it 'returns true if the argument is Numeric and all the element classes are either Integer, Float or Complex' do
      expect(array.my_all?(Numeric)).to eql true
    end

    it 'returns true if the argument class is Integer, Float or String and all the elements inside that array equal the argument' do
      expect(threes_array.my_all?(3)).to eql true
    end
  end
end
# rubocop:enable Layout/LineLength
