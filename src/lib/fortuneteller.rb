require_relative './previous_life'
require 'ruby-progressbar'
require 'httparty'

class FortuneTeller
  include HTTParty
  base_uri "api.quotable.io/"

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet(username = "Traveller")
    return "Hello and welcome #{username}! I am #{@name}, your most truthful fortune teller.\nI talk to the SPIRITS, and the SPIRITS never lie.\nAre you ready to look your destiny in the eye?\n"
  end

  def farewell(username = "Traveller")
    return "\nI hope you found what you were looking for #{username}. Farewell!"
  end

  def output_options()
    return "Options:\n1) What does my future hold?\n2) Who was I in previous life?\n3) Display my fortunes\n4) Bye Cassandra\n"
  end

  def clear_aura()
    progressbar = ProgressBar.create(title: "Clearning aura", unknown_progress_animation_steps: ['~~--', '-~~-', '--~~'], total: nil)
    20.times {progressbar.increment; sleep 0.1}
  end
  
  def consult_spirits()
    progressbar = ProgressBar.create(title: "Consulting spirits", unknown_progress_animation_steps: ['~~--', '-~~-', '--~~'], total: nil)
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
      self.clear_aura
      system "clear"
  end
end