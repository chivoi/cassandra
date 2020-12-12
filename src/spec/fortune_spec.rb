require_relative "../lib/fortune.rb"
require_relative "../lib/log.rb"
require_relative "../lib/fortuneteller.rb"

describe 'fortune' do
  
  it 'should be an instance of a Fortune' do
    expect(Fortune.new).to be_a Fortune
  end

end