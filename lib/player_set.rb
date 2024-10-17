# frozen_string_literal: true

# Contains player objects
class PlayerSet
  attr_accessor :player_count, :players

  def initialize
    @player_count = 0
    @players = []
  end
end
