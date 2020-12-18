#!/usr/bin/ruby
require_relative './lib/fortuneteller'
require_relative './lib/log'
require_relative './lib/errors'
require_relative './lib/previous_life'
require 'artii'
require 'tty-markdown'
require 'tty-box'
require 'rainbow'
require 'tty-screen'

# Handling command line arguments
if ARGV.length > 0
  flag, *rest = ARGV
  ARGV.clear
  case flag 
  when '-h'
    parsed = TTY::Markdown.parse_file("../README.md", theme: { 
      em: :bright_cyan,
      header: [:bright_magenta, :bold],
      hr: :bright_cyan,
      link: [:bright_cyan, :underline],
      list: :bright_cyan,
      strong: [:bright_cyan, :bold],
      table: :bright_blue,
      quote: :bright_blue,
      image: :bright_black,
      note: :bright_cyan,
      comment: :bright_black
      })
    puts parsed
    exit
  when '-p'
    file_path = Log.new(rest[0])
  when '-n'
    username = rest[0]
  when '-v'
    puts "This is Cassandra 0.0.1\nIt uses Ruby version #{RUBY_VERSION}"
    exit
  else
      puts "Enter valid argument:\n-h for programme info\n-v for version info\n-p file/path to pass in your previous fortunes\n-n YourName to let Cassandra know your name before your seance starts" 
      exit
  end
end 

# variables
cassandra = FortuneTeller.new("Cassandra")
fortunes_book ||= Log.new("./logs/fortunes-from-cassandra.txt")
notice = Pastel.new.bright_magenta.detach
prompt = TTY::Prompt.new(active_color: notice)
screen_width = TTY::Screen.cols

# making the heading responsive to the terminal window width
screen_width < 82 ? (heading = Artii::Base.new :font => 'thin') : (heading = Artii::Base.new :font => 'nancyj-underlined')

# main programme start
system "clear"

puts Rainbow(heading.asciify(cassandra.name)).mediumpurple
puts File.readlines("./image.txt") if screen_width > 68

puts Rainbow(cassandra.greet()).mediumpurple.italic
sleep 1.5

# Main programme loop
begin
  loop do
    choices = [
      {name: "What does my future hold", value: 1},
      {name: "Who was I in past life", value: 2},
      {name: "Display my fortunes", value: 3},
      {name: "Bye #{cassandra.name}!", value: 4}
    ]
    answer = prompt.select("\nWhat can I do for you?", choices, symbols: { marker: "~" })
    case answer
    when 1 
      loop do
        puts cassandra.progressbar("Consutling spirits")
        fortune = cassandra.tell_fortune
        fortunes_book.add_fortune(fortune)
        system "clear"
        box = TTY::Box.frame(width: 70, height: 8, align: :center, border: :ascii, padding: 1) do
          "#{fortune}"
        end
        puts Rainbow(box).mediumpurple
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
      puts cassandra.progressbar("Consulting spirits")
      previous_life = cassandra.tell_previous_life
      system "clear"
      puts Rainbow(previous_life).mediumpurple
      fortunes_book.add_fortune(previous_life)
      sleep 2
      answer = prompt.yes?("\nWould you like me to save it to your Fortunes Book?")
      if answer == true
        fortunes_book.write_to_file(previous_life)
        puts "\nDone!\n"
      end
      cassandra.clear_screen
    when 3
      cassandra.progressbar("Consulting spirits")
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
      else 
        puts Rainbow("\nNothing to display yet.").mediumpurple.italic
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
          puts Rainbow("\nFind it here: #{fortunes_book.show_file_path}\n\n").mediumpurple.italic
        elsif answer == 2
          fortunes_book.delete_file
          puts Rainbow("\nFortunes Book deleted!\n\n").mediumpurple.italic
        end
      end
      cassandra.progressbar("Cleansing aura")
      puts Rainbow(cassandra.farewell(username)).italic.mediumpurple
      exit
    else 
      raise ValidationError
    end
  end
rescue
  puts "\nThe future is unclear. Try again later."
  exit
end