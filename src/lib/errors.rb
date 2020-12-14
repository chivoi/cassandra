class ValidationError < StandardError
  def message
    return "\nYou should be very clear while talking to spirits! Please input the valid option"
  end
end