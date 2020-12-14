require 'ruby-progressbar'
class FortuneTeller
  
  attr_reader :name

  def initialize(name)
    @name = name
    @fortune = 
  end

  def greet()
    return "Hello and welcome! I am #{@name}, your most truthful fortune teller.\n I talk to SPIRITS, and SPIRITS never lie. \n Are you ready to look your destiny in the eye?"
  end
  
  def consult_spirits()
    progressbar = ProgressBar.create(title: "Consulting spirits", unknown_progress_animation_steps: ['~~--', '-~~-', '--~~'], total: nil)
    20.times {progressbar.increment; sleep 0.1}
  end
end
