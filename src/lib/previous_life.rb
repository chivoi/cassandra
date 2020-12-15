require 'httparty'
require 'terminal-table'

class PreviousLife
  include HTTParty
  base_uri "pipl.ir/v1/"

  def display_previous_life
    person_hash = self.class.get('/getPerson').parsed_response["person"]
    rows = []
    rows << ['First name', person_hash["personal"]["name"]]
    rows << ['Last name', person_hash["personal"]["last_name"]]
    rows << ['Age', person_hash["personal"]["age"]]
    rows << ['Birth place', person_hash["personal"]["country"]]
    rows << ['Partner\'s name', person_hash["personal"]["father_name"]]
    rows << ['Marriage', person_hash["marriage"]["married"]]
    rows << ['Eye color', person_hash["personal"]["eye_color"]]
    rows << ['Height', "#{person_hash["personal"]["height"]} m"]
    rows << ['Weight', "#{person_hash["personal"]["weight"]} kg"]
    rows << ['Profession', person_hash["work"]["position"]]
    rows << ['Salary', "#{person_hash["work"]["salary"]} per month"]
    table = Terminal::Table.new :rows => rows
  end

end