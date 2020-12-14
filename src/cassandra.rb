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
begin
  loop do
    cassandra.output_options
    asnwer = gets.strip.to_i

    case asnwer
    when 1 
      loop do
        cassandra.consult_spirits
        puts cassandra.tell_fortune
        cassandra.write_to_file
        puts "\nWould you like me to save it to your Fortunes Book? Y/N"
        answer = gets.strip.downcase
        if answer == "y" || answer = "yes"
          cassandra.read_from_file.write_to_file
          puts "\nDone!"
        end
        puts "\nWould you like another prediction? Y/N"
        input = gets.strip.downcase
        break if input == "n" || input == "no"
      end
      cassandra.clear_screen
    when 2
      fortunes_book = Log.new(file_path) #put the ARGV file path?
      cassandra.consult_spirits 
      puts fortunes_book.read_from_file
      clear_screen()
    when 3
      puts "\nWould you like to save your Fortunes Book? Y/N"
      answer = gets.strip.downcase
        if answer == "y" || answer = "yes"
          puts "\nSaved here: #{fortunes_book.show_file_path}"
        elsif answer == "n" || answer == "no"
          fortunes_book.delete_file
          puts "\nDone!"
        end
      cassandra.clear_aura.farewell
      exit
    else 
      raise ValidationError
    end
    cassandra.clear_aura.clear_screen
  end
rescue ValidationError
  ValidationError.new.message
  retry
rescue
  puts "\nThe future is unclear. Try again later."
  exit
end