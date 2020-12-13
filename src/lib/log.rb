require_relative "fortune.rb"
class Log

  attr_reader :name, :file_path, :todays_fortunes
  
  def initialize(name, file_path)
    @name = name
    @file_path = file_path
    @todays_fortunes = {}
    @time = Time.now.strftime("%d %B, %Y %H:%M")
    @fortune = Fortune.new
  end

  def add_fortune(time, fortune)
    @todays_fortunes < {@time => @fortune.tell.to_s}
  end
end

log = Log.new("My prophesies", "../logs/test-log.txt")
p todays_prophesies = log.add_fortune(Time.now, Fortune.new.tell)