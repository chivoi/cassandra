require_relative "fortune.rb"
class Log

  attr_reader :name, :todays_fortunes, :file_path
  
  def initialize(name, file_path)
    @name = name
    @todays_fortunes = []
    @file_path = file_path
    @fortune = Fortune.new.tell.to_s
  end

  def add_fortune(fortune)
    return @todays_fortunes.push(fortune)
  end
end