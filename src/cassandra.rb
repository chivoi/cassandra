#!/usr/bin/ruby
require_relative './lib/fortuneteller'
require_relative './lib/log'

# Handling command line arguments
if ARGV.length > 0
  flag, *rest = ARGV
  ARGV.clear
  case flag 
  when '-h'
    help = File.readlines("../README.md")
    help.map{|line| puts line}
    exit
  when '-v'
    puts "This is Cassandra 0.0.1\nIt uses Ruby version: #{RUBY_VERSION}"
    exit
  else
      puts "Enter valid argument:"
      puts "-h for programme info"
      puts "-v for version info"
      exit
  end
end 

cassandra = FortuneTeller.new("Cassandra")

puts cassandra.greet

# Main programme loop
loop do
  cassandra.output_options
  asnwer = gets.strip.to_i

  case asnwer
  when 1 
    loop do
      cassandra.consult_spirits
      puts cassandra.tell_fortune
      cassandra.write_to_file
      puts "Would you like me to save it to your Fortunes Book? Y/N"
      answer = gets.strip.downcase
      if answer == "y" || answer = "yes"
        cassandra.read_from_file.write_to_file
        puts "Done!"
      end
      puts "\nWould you like another prediction? Y/N"
      input = gets.strip.downcase
      break if input == "n" || input == "no"
    end
    puts "Press any key to continue"
      gets
      cassandra.clear_aura
      system "clear"
  when 2
    fortunes_book = Log.new(file_path) #put the ARGV file path?
    cassandra.consult_spirits 
    fortunes_book.read_from_file
    
    #start here
    
    if File.exist?(fortunes_file)
      pause()
      File.readlines(fortunes_file).map {|fortune| puts fortune}
      puts "Save your fortunes? 1 yes 2 no"
      input = gets.strip.to_i
      if input == 2
        File.delete("fortunes-from-cassandra.txt")
      elsif input == 1
        puts "Saved here: #{File.expand_path(File.dirname(fortunes_file))}"
      end
    else
      puts "No fortunes yet. Let\'s give you your first one!"
    end
  when 3
    if File.exist?(fortunes_file)
      puts "Save your fortunes? 1 yes 2 no"
      input = gets.strip.to_i
      if input == 2
        File.delete("fortunes-from-cassandra.txt")
      elsif input == 1
        puts "Saved here: #{File.expand_path(File.dirname(fortunes_file))}"
      end
    end
    exit
  else 
    "Invalid option" #raise ValidationError
  end
end
