require './app.rb'

describe Enumerable do
  let(:array) { [1, 2, 3] }
  describe '#my_each' do
    it "doesn't modify the original array" do
      expect(array.my_each { |n| n + 2 }).to eql array
    end

    it "accepts a range" do
      expect((1..9).my_each { |n| n + 2 }).to eql (1..9)
    end

    it 'returns an enumerator if no block is given' do
      expect(array.my_each).to be_an Enumerator
    end
  end

  describe '#my_each_with_index' do
    it "doesn't modify the original array" do
      expect(array.my_each_with_index { |n| n + 2 }).to eql array
    end

    it "accepts a range" do
      expect((1..9).my_each_with_index { |n| n + 2 }).to eql (1..9)
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
end
