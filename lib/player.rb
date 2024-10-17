# frozen_string_literal: true

# Handles 2 player data
class Player
  attr_reader :name, :symbol, :color

  SYMBOL = %i[X Y].freeze
  COLOR = { X: 'red', Y: 'blue' }.freeze

  def initialize(name, base)
    @name = name
    @symbol = SYMBOL[base.player_count]
    @color = COLOR[@symbol]
    base.player_count += 1
    base.players << self
  end
end
