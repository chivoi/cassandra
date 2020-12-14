require_relative "fortuneteller"
class Log

  attr_reader :todays_fortunes, :file_path
  
  def initialize(file_path)
    @file_path = file_path
    @todays_fortunes = []
    @fortune = FortuneTeller.new("Cassandra").tell_fortune
  end

  def add_fortune(fortune)
    return @todays_fortunes.push(fortune)
  end

  def display_fortunes
    return todays_fortunes.each{|fortune| fortune}
  end

  def read_from_file
    begin
      fortunes = File.readlines(@file_path).map{|fortune| fortune.strip}
    rescue
      puts "Looks like you don't have any saved fortunes yet. Creating your personal Fortunes Book."
      File.open("./logs/fortunes-from-cassandra.txt", "w") {|file| file.write("")}
      fortunes = @todays_fortunes
    end
    return fortunes
  end

  def write_to_file
    File.open(@file_path, "a") {|file| file.write("\n#{Time.now.strftime("%d %B, %Y %H:%M")}\n#{self.display_fortunes.join("\n")}") }
  end

  def delete_file
    File.delete(@file_path)
  end

  def show_file_path
    File.expand_path(File.dirname(@file_path))
  end

end