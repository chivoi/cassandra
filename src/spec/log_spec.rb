require_relative "../lib/log.rb"
require_relative "../lib/fortune.rb"

describe "log" do
  before(:each) do
    @log = Log.new("Test log", "./logs/test-log.txt")
    # @fortunes = File.readlines("../logs/test-log.txt").map{|fortune| fortune}
  end
  
  it "should be an instance of a Log" do
    expect(@log).to be_a Log
  end

  it "should initialize with a name" do
    expect(@log.name).to eq("Test log")
  end
  
  it "should have an array of fortunes" do
    expect(@log.todays_fortunes).to be_a Array
  end

  it "should have a file path as String" do
    expect(@log.file_path).to be_an_instance_of(String)
  end

  it "should have a file path that matches the file directory" do
    expect(@log.file_path).to match(/^\.{1}\/logs\/\S+/)
  end
  
  describe ".add_fortune" do
    it "should be defined" do
      expect(defined? @log.add_fortune).to eq("method")
    end
    
    it "should increase the length of the array of fortunes" do
      length = @log.todays_fortunes.length
      fortune = Fortune.new.tell
      expect(@log.add_fortune(fortune).length).to be length+1
    end
  end

  describe ".display_fortunes" do
    it "should be defined" do
      expect(defined? @log.display_fortunes).to eq("method")
    end

    it "should output fortunes log to screen" do
      expect(@log.display_fortunes).to include(*@log.todays_fortunes)
    end
  end

  describe ".read_from_file" do
    it "should be defined" do
      expect(defined? @log.read_from_file).to eq("method")
    end

    it "should return an array from the contents of file" do
      expect(@log.read_from_file).to be_a Array
    end

    it 'should remove newlines from array entries' do
      expect(@log.read_from_file[0]).not_to include("\n")
    end
  end
end