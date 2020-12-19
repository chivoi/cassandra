class ValidationError < StandardError
  def message
    return "\nYou should be very clear while talking to spirits! Please choose the valid option"
  end
end