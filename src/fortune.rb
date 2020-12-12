require 'httparty'

class Fortune
  include HTTParty
  base_uri "api.quotable.io/"

  def quote
    self.class.get('/random').parsed_response["content"]
  end

  def to_s
    return "#{self.quote}"
  end
end