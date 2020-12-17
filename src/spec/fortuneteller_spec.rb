require_relative "../lib/fortuneteller"
require_relative "../lib/log"
require_relative "../lib/previous_life"
require "terminal-table"

describe 'FortuneTeller' do
  before(:each) do
    @fortuneteller = FortuneTeller.new("Cassandra")
  end

  it "should be an instance of a FortuneTeller" do
    expect(@fortuneteller).to be_a FortuneTeller
  end

  it "should initialize with a name" do
    expect(@fortuneteller.name).to eq("Cassandra")
  end

  describe '.greet' do
    it "should display a greeting" do
      expect(@fortuneteller.greet).to be_a String
    end 
  end

  describe '.farewell' do
    it "should display a farewell message" do
      expect(@fortuneteller.farewell).to be_a String
    end
    it "should use the username" do
      expect(@fortuneteller.farewell("Ana")).to include("Ana")
    end
    it "should use Traveller when no name is passed" do
      expect(@fortuneteller.farewell).to include("Traveller")
    end
  end

  describe '.progressbar' do
    it "should be an istance of a ProgressBar" do
      expect(@fortuneteller.progressbar("Message")).to be_a Integer
    end
  end

  describe '.tell_fortune' do
    it 'should get a string quote from quotable API' do
      expect(@fortuneteller.tell_fortune).to be_a String
     end
  end
  
  describe '.tell_previous_life' do
    it 'should return a table from PreviousLife class' do
      prevlife = PreviousLife.new
      expect(@fortuneteller.tell_previous_life).to be_a Terminal::Table
    end
  end
end