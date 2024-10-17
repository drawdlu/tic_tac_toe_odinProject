# frozen_string_literal: true

# Handles 2 player data
class Player
  attr_reader :name, :symbol, :color

  SYMBOL = %i[x y].freeze
  COLOR = { x: 'red', y: 'blue' }.freeze

  def initialize(name, base)
    @name = name
    @symbol = SYMBOL[base.player_count]
    @color = COLOR[@symbol]
    base.player_count += 1
    base.players << self
  end
end
