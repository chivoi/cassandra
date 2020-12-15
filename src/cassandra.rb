#!/usr/bin/ruby
require_relative './lib/fortuneteller'
require_relative './lib/log'
require_relative './lib/errors'
require_relative './lib/previous_life'
require 'artii'
require 'tty-markdown'

# Handling command line arguments
if ARGV.length > 0
  flag, *rest = ARGV
  ARGV.clear
  case flag 
  when '-h'
    # help = File.readlines("../README.md")
    # help.map{|line| puts line}
    parsed = TTY::Markdown.parse_file("../README.md")
    puts parsed
    exit
  when '-p'
    file_path = Log.new(rest[0])
  when '-n'
    username = rest[0]
  when '-v'
    puts "This is Cassandra 0.0.1\nIt uses Ruby version: #{RUBY_VERSION}"
    exit
  else
      puts "Enter valid argument:\n-h for programme info\n-v for version info\n-p file/path to pass in your previous fortunes\n-n YourName to let Cassandra know your name before your seance starts" 
      exit
  end
end 

cassandra = FortuneTeller.new("Cassandra")
fortunes_book ||= Log.new("./logs/fortunes-from-cassandra.txt")

heading = Artii::Base.new :font => 'nancyj-underlined'
puts heading.asciify('Cassandra')

puts cassandra.greet(username)
sleep 1.5

# Main programme loop
# begin
  loop do
    puts cassandra.output_options
    asnwer = gets.strip.to_i

    case asnwer
    when 1 
      loop do
        puts cassandra.consult_spirits
        fortune = cassandra.tell_fortune
        puts fortune
        fortunes_book.add_fortune(fortune)
        sleep 2
        puts "\nWould you like me to save it to your Fortunes Book? Y/N\n"
        answer = gets.strip.downcase
        if answer == "y" || answer == "yes"
          fortunes_book.write_to_file(fortune)
          puts "\nDone!\n"
        end
        cassandra.clear_screen
        puts "\nWould you like another fortune? Y/N\n"
        input = gets.strip.downcase
        break if input == "n" || input == "no"
      end
      cassandra.clear_screen
    when 2
      puts cassandra.consult_spirits
        previous_life = cassandra.tell_previous_life
        puts previous_life
        fortunes_book.add_fortune(previous_life)
        sleep 2
        puts "\nWould you like me to save it to your Fortunes Book? Y/N\n"
        answer = gets.strip.downcase
        if answer == "y" || answer == "yes"
          fortunes_book.write_to_file(previous_life)
          puts "\nDone!\n"
        end
        cassandra.clear_screen
    when 3
      cassandra.consult_spirits
      if File.exist?(fortunes_book.file_path)
        if fortunes_book.todays_fortunes.length > 0
          puts "Press 1 to display this seance's fortunes, 2 to display all fortunes from your Book"
          answer = gets.chomp.to_i
          if answer == 1
            puts fortunes_book.display_fortunes
          elsif answer == 2
            puts fortunes_book.read_from_file
          end
        else 
          puts fortunes_book.read_from_file
        end
      end
      cassandra.clear_screen()
    when 3
      if File.exist?(fortunes_book.file_path)
        puts "\nWould you like to save your Fortunes Book? Y - keep /  N - delete\n"
        answer = gets.strip.downcase
        if answer == "y" || answer == "yes"
          puts "\nSaved here: #{fortunes_book.show_file_path}\n"
        elsif answer == "n" || answer == "no"
          fortunes_book.delete_file
          puts "\nFortunes Book deleted!\n"
        end
      end
      cassandra.clear_aura
      puts cassandra.farewell
      exit
    else 
      raise ValidationError
    end
  end
# rescue
#   puts "\nThe future is unclear. Try again later."
#   exit
# end