require_relative "../lib/errors"

describe "ValidationError" do
  it "should be an instance of a ValidationError" do
    expect(ValidationError.new).to be_a ValidationError
  end

  describe ".message" do
    it "should return an error message as a string" do
      expect(ValidationError.new.message).to be_a String
    end
  end
end