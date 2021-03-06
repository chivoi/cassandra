require_relative './previous_life'
require_relative './fortuneteller'
require 'ruby-progressbar'
require 'httparty'
require 'tty-prompt'

class FortuneTeller
  include HTTParty
  base_uri "api.quotable.io/"

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet()
    return "I speak to the SPIRITS, and the SPIRITS never lie.\nAre you ready to look your destiny in the eye?\n"
  end

  def farewell(username)
    return "\n\nI hope you found what you were looking for, #{username}. Farewell!\n"
  end

  def progressbar(message)
    progressbar = ProgressBar.create(title: message, unknown_progress_animation_steps: ['~~--', '-~~-', '--~~'], total: nil)
    20.times {progressbar.increment; sleep 0.1}
  end

  def tell_fortune()
    fortune = self.class.get('/random').parsed_response["content"]
    return "\n#{fortune}"
  end

  def tell_previous_life()
    fortune = PreviousLife.new.display_previous_life()
    return fortune
  end

  def clear_screen()
    puts "\nPress any key to continue"
      gets
      self.progressbar("Cleansing aura")
      system "clear"
  end
end