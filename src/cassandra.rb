#!/usr/bin/ruby
require_relative 'fortune'

def pause()
  puts ""
  3.times do 
      sleep(2/3.0) 
      print "."
  end 
  puts ""
end

fortunes_file = "./fortunes-from-cassandra.txt"

puts "Hello and welcome"

# Main programme loop
loop do
  puts "Options:"
  puts "1) What's in my nearest future?"
  puts "2) Display my fortunes"
  puts "3) Quit"

  asnwer = gets.strip.to_i

  case asnwer
  when 1 
    loop do
      todays_fortune = Fortune.new
      pause()
      puts todays_fortune.quote
      File.open(fortunes_file, "a") {|file| file.write("#{Time.now.strftime("%d %B, %Y %H:%M")} - #{todays_fortune.to_s}\n") }
      puts "Would you like another? 1 yes 2 no"
      input = gets.strip.to_i
      break if input == 2
    end
    puts "Press any key to continue"
      gets
      system "clear"
  when 2
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
