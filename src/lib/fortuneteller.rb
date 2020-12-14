require 'ruby-progressbar'
require 'httparty'
class FortuneTeller
  include HTTParty
  base_uri "api.quotable.io/"

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet()
    return "Hello and welcome! I am #{@name}, your most truthful fortune teller.\n I talk to SPIRITS, and SPIRITS never lie. \n Are you ready to look your destiny in the eye?"
  end

  def farewell()
    return "I hope you found what you were looking for. Farewell!"
  end

  def output_options()
    return "Options:\n1) What does my future hold?\n2) Display my fortunes\n3)Bye Cassandra"
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
    return self.class.get('/random').parsed_response["content"]
  end

  def clear_screen()
    puts "Press any key to continue"
      gets
      cassandra.clear_aura
      system "clear"
  end
end