require_relative "fortune.rb"
class Log

  attr_reader :name, :todays_fortunes, :file_path
  
  def initialize(name, file_path)
    @name = name
    @file_path = file_path
    @todays_fortunes = []
    @fortune = Fortune.new.tell
  end

  def add_fortune(fortune)
    return @todays_fortunes.push(fortune)
  end

  def display_fortunes
    return "Today's fortunes:\n#{todays_fortunes.each{|fortune| puts fortune}}"
  end

  def read_from_file
    fortunes = File.readlines(@file_path).map{|fortune| fortune.strip}
    return fortunes
  end
end

log = Log.new("Fortunes", "./logs/test-log.txt")
p log.read_from_file