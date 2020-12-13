require 'httparty'

class Fortune
  include HTTParty
  base_uri "api.quotable.io/"

  def tell
    return self.class.get('/random').parsed_response["content"]
  end
end