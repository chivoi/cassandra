require_relative "../lib/fortuneteller"
require_relative "../lib/log"

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
    it "should greet the user by name" do
      expect(@fortuneteller.greet("Ana")).to include("Ana")
    end
    it "should use Traveller when no name is passed" do
      expect(@fortuneteller.greet).to include("Traveller")
    end
  end

  describe '.farewell' do
    it "should display a greeting" do
      expect(@fortuneteller.farewell).to be_a String
    end
    it "should use the username" do
      expect(@fortuneteller.farewell("Ana")).to include("Ana")
    end
    it "should use Traveller when no name is passed" do
      expect(@fortuneteller.farewell).to include("Traveller")
    end
  end
  
  describe '.output_options' do
    it "should display options" do
      expect(@fortuneteller.output_options).to be_a String
    end
  end

  describe '.consult_spirits' do
    it "should display a progress bar" do
      expect{ print(@fortuneteller.consult_spirits) }.to output.to_stdout
    end 
  end

  describe '.clear_aura' do
    it "should display a progress bar" do
      expect{ print(@fortuneteller.clear_aura) }.to output.to_stdout
    end 
  end

  describe '.tell_fortune' do
    it 'should be defined' do
      expect(defined? @fortuneteller.tell_fortune).to eq('method')
    end

    it 'should get a string quote from quotable API' do
      expect(@fortuneteller.tell_fortune).to be_a String
     end
  end
end