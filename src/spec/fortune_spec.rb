require_relative "../lib/fortune.rb"

describe 'fortune' do
  
  before(:each) do
    @fortune = Fortune.new
  end

  it 'should be an instance of a Fortune' do
    expect(@fortune).to be_a Fortune
  end

  describe '.tell' do

    it 'should be defined' do
      expect(defined? @fortune.tell).to eq('method')
    end

    it 'should get a string quote from quotable API' do
      expect(@fortune.tell).to be_a String
     end
  end
end