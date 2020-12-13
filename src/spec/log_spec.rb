require_relative "../lib/log.rb"
require_relative "../lib/fortune.rb"

describe "log" do
  before(:each) do
    @log = Log.new("Test log", "../logs/test-log.txt")
    @todays_fortunes = {}
    @fortune = Fortune.new
    @time = Time.now
  end
  
  it "should be an instance of a Log" do
    expect(@log).to be_a Log
  end

  it "should initialize with a name" do
    expect(@log.name).to eq("Test log")
  end
  
  it "should have an hash of fortunes" do
    expect(@log.todays_fortunes).to be_a Hash
  end

  it "should have a file path as String" do
    expect(@log.file_path).to be_an_instance_of(String)
  end

  it "should have a file path that matches the file directory" do
    expect(@log.file_path).to match(/^\.\.{1}\/logs\/\S+/)
  end
  
  describe ".add_fortune" do
    it "should be defined" do
      expect(defined? @log.add_fortune).to eq("method")
    end
    
    it "should add something to the hash of fortunes" do
      expect(@log.add_fortune(@time, @fortune.tell)).not_to be_empty
    end
  end
end