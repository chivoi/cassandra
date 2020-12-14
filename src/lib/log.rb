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
    return todays_fortunes.each{|fortune| fortune}
  end

  def read_from_file
    fortunes = File.readlines(@file_path).map{|fortune| fortune.strip}
    return fortunes
  end

  def write_to_file
    File.open(@file_path, "a") {|file| file.write("\n#{Time.now.strftime("%d %B, %Y %H:%M")}\n#{self.display_fortunes.join("\n")}") }
  end

  def delete_file
    File.delete(@file_path)
  end

end

# log = Log.new("Test", "")

# 2.times do 
#   fortune = Fortune.new.tell
#   log.add_fortune(fortune)
# end

# log.write_to_file