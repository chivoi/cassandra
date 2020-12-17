require_relative "../lib/previous_life"
require 'terminal-table'

describe 'PreviousLife' do
  before(:each) do
    @previous_life = PreviousLife.new
  end

  it "should be an instance of a PreviousLife" do
    expect(@previous_life).to be_a PreviousLife
  end

  describe '.display_previous_life' do
    it 'should get information from API' do
      expect{print(@previous_life.display_previous_life)}.to output.to_stdout
     end

    it 'should return a table' do
      expect(@previous_life.display_previous_life).to be_a Terminal::Table
    end
  end
end