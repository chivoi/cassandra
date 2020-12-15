#!/usr/bin/ruby
require_relative './lib/fortuneteller'
require_relative './lib/log'
require_relative './lib/errors'

# Handling command line arguments
if ARGV.length > 0
  flag, *rest = ARGV
  ARGV.clear
  case flag 
  when '-h'
    help = File.readlines("../README.md")
    help.map{|line| puts line}
    exit
  when '-p'
    file_path = Log.new(rest[0])
  when '-n'
    username = rest[0]
  when '-v'
    puts "This is Cassandra 0.0.1\nIt uses Ruby version: #{RUBY_VERSION}"
    exit
  else
      puts "Enter valid argument:\n-h for programme info\n-v for version info\n-p file/path to pass in your previous fortunes\n-n YourName to let Cassandra know your name" 
      exit
  end
end 

cassandra = FortuneTeller.new("Cassandra")
fortunes_book ||= Log.new("./logs/fortunes-from-cassandra.txt")

puts cassandra.greet(username)
sleep 1.5
puts cassandra.clear_screen

# Main programme loop
# begin
  loop do
    puts cassandra.output_options
    asnwer = gets.strip.to_i

    case asnwer
    when 1 
      loop do
        puts cassandra.consult_spirits
        puts cassandra.tell_fortune
        fortunes_book.write_to_file
        puts "\nWould you like me to save it to your Fortunes Book? Y/N"
        answer = gets.strip.downcase
        if answer == "y" || answer == "yes"
          fortunes_book.read_from_file
          fortunes_book.write_to_file
          puts "\nDone!"
        end
        puts "\nWould you like another prediction? Y/N"
        input = gets.strip.downcase
        break if input == "n" || input == "no"
      end
      cassandra.clear_screen
    when 2
      cassandra.consult_spirits 
      puts fortunes_book.read_from_file
      cassandra.clear_screen()
    when 3
      puts "\nWould you like to save your Fortunes Book? Y/N"
      answer = gets.strip.downcase
        if answer == "y" || answer == "yes"
          puts "\nSaved here: #{fortunes_book.show_file_path}"
        elsif answer == "n" || answer == "no"
          fortunes_book.delete_file
          puts "\nDone!"
        end
      cassandra.clear_aura
      cassandra.farewell
      exit
    else 
      raise ValidationError
    end
    cassandra.clear_aura
    cassandra.clear_screen
  end
# rescue
#   puts "\nThe future is unclear. Try again later."
#   exit
# end