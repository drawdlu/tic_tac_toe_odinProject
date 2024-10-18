# frozen_string_literal: true

# number helper methods
module Numbers
  # just return -1 if no numbers in input
  def get_digit(number)
    digit = number.match(/\d+/)
    digit.nil? ? -1 : digit[0].to_i
  end
end
