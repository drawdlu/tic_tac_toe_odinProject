# frozen_string_literal: true

# digit operations
module Numbers
  def numeric?(input)
    input.match?(/[[:digit:]]/)
  end
end
