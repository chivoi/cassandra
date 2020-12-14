require_relative "../lib/fortuneteller"
require_relative "../lib/log"
require_relative "../lib/fortune"

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
  describe '.consult_spirits' do
    it "should display a progress bar" do
      expect{ print(@fortuneteller.consult_spirits) }.to output.to_stdout
    end 
  end
end