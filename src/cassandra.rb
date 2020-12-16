#!/usr/bin/ruby
require_relative './lib/fortuneteller'
require_relative './lib/log'
require_relative './lib/errors'
require_relative './lib/previous_life'
require 'artii'
require 'tty-markdown'
require 'tty-box'

# Handling command line arguments
if ARGV.length > 0
  flag, *rest = ARGV
  ARGV.clear
  case flag 
  when '-h'
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
notice = Pastel.new.bright_magenta.detach
prompt = TTY::Prompt.new(active_color: notice) 

system "clear"

heading = Artii::Base.new :font => 'nancyj-underlined'
puts heading.asciify('Cassandra')
puts File.readlines("./image.txt")
# puts cassandra.image

puts cassandra.greet(username)
sleep 1.5

# Main programme loop
# begin
  loop do
    choices = [
      {name: "What does my future hold", value: 1},
      {name: "Who was I in previous life", value: 2},
      {name: "Display my fortunes", value: 3},
      {name: "Bye #{cassandra.name}!", value: 4}
    ]
    answer = prompt.select("\nWhat can I do for you?", choices, symbols: { marker: "~" })
    case answer
    when 1 
      loop do
        puts cassandra.consult_spirits
        fortune = cassandra.tell_fortune
        system "clear"
        box = TTY::Box.frame(width: 70, height: 8, align: :center, border: :ascii, padding: 2,
            style: {
            fg: :bright_magenta,
            bg: :black,
            border: {
              fg: :bright_blue,
              bg: :black}}) do
          "#{fortune}"
        end
        puts box
        fortunes_book.add_fortune(fortune)
        answer = prompt.yes?("\nWould you like me to save it to your Fortunes Book?")
        if answer == true
          fortunes_book.write_to_file(fortune)
          puts "\nDone!\n"
        end
        cassandra.clear_screen
        answer = prompt.yes?("\nWould you like another prediction?")
        break if answer == false
      end
      cassandra.clear_screen
    when 2
      puts cassandra.consult_spirits
        previous_life = cassandra.tell_previous_life
        puts previous_life
        fortunes_book.add_fortune(previous_life)
        sleep 2
        answer = prompt.yes?("\nWould you like me to save it to your Fortunes Book?")
        if answer == true
          fortunes_book.write_to_file(previous_life)
          puts "\nDone!\n"
        end
        cassandra.clear_screen
    when 3
      cassandra.consult_spirits
      if File.exist?(fortunes_book.file_path)
        if fortunes_book.todays_fortunes.length > 0
          choices = [
            {name: "This seance", value: 1},
            {name: "The whole thing", value: 2},
          ]
          answer = prompt.select("\nDisplay fortunes for just this seance, or all fortunes from your Fortunes Book?", choices, symbols: { marker: "~" })
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
    when 4
      if File.exist?(fortunes_book.file_path)
        choices = [
          {name: "Keep", value: 1},
          {name: "Delete", value: 2},
        ]
        answer = prompt.select("\nKeep the fortunes book for your life guidance or delete it?", choices, symbols: { marker: "~" })
        if answer == 1
          puts "\nFind it here: #{fortunes_book.show_file_path}\n\n"
        elsif answer == 2
          fortunes_book.delete_file
          puts "\nFortunes Book deleted!\n\n"
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