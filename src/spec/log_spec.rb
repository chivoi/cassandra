require_relative "../lib/log.rb"
require_relative "../lib/fortuneteller.rb"

describe "log" do
  before(:each) do
    @log = Log.new("./logs/test-log.txt")
    @cassandra = FortuneTeller.new("Cassandra")
  end
  
  it "should be an instance of a Log" do
    expect(@log).to be_a Log
  end

  it "should initialize with a file path that matches the file directory" do
    expect(@log.file_path).to match(/^\.{1}\/logs\/\S+/)
  end
  
  it "should have an array of fortunes" do
    expect(@log.todays_fortunes).to be_a Array
  end

  it "should have a file path as String" do
    expect(@log.file_path).to be_an_instance_of(String)
  end
  
  describe ".add_fortune" do
    it "should be defined" do
      expect(defined? @log.add_fortune).to eq("method")
    end
    
    it "should increase the length of the array of fortunes" do
      length = @log.todays_fortunes.length
      fortune = @cassandra.tell_fortune
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

    it 'should populate array with fortunes from file' do
      fortunes = File.readlines("./logs/test-log.txt").map{|fortune| fortune.strip}
      expect(@log.read_from_file).to include(fortunes[0])
    end

    it "should create file if no file found" do
      empty_log = Log.new("")
      empty_log.read_from_file
      expect(File).to exist(@log.file_path)
    end
  end

  describe ".write_to_file" do
    it "should be defined" do
      expect(defined? @log.write_to_file).to eq("method")
    end

    it "should append to the file" do
      fortune = @cassandra.tell_fortune
      @log.add_fortune(fortune)
      length = @log.read_from_file.length
      @log.write_to_file(fortune)
      expect(@log.read_from_file.length).to be > length
    end
  end

  describe ".show_file_path" do
    it 'should output the file path to the screen' do
      expect(@log.show_file_path). to include("logs")
    end
  end

  describe ".delete_file" do
    it "should be defined" do
      expect(defined? @log.delete_file).to eq("method")
    end

    it "should delete the log file" do
      @log.delete_file
      expect(File).not_to exist(@log.file_path)
    end

    File.open("./logs/test-log.txt", "w+") {|file| file.write("The future is unclear")}
  end

end