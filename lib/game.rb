# frozen_string_literal: true

require_relative 'numbers'

# Handle game loop
class Game
  include Numbers

  def initialize(player_set, board)
    @player_set = player_set
    @board = board
    @win = false
    @active = 0
  end

  def start
    puts @board

    until @win
      current_player = get_player(active)
      number = input_loop(current_player)

      @board.place_symbol(current_player.symbol, number)
      puts @board

      self.active = switch_active(active)
    end
  end

  private

  attr_accessor :active

  def within_range?(number)
    number.to_i < 9 && number.to_i >= 0
  end

  def switch_active(active_index)
    active_index.zero? ? 1 : 0
  end

  def get_player(active)
    @player_set.players[active]
  end

  def prompt_input(player)
    print "#{player.name}'s turn to pick a number: "
  end

  def input_loop(player)
    loop do
      prompt_input(player)
      number = get_digit(gets.chomp)
      return number if within_range?(number) && @board.empty?(number)
    end
  end
end
