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
      current_player = @player_set.players[active]

      print "#{current_player.name}'s turn to pick a number: "
      number = get_digit(gets.chomp)
      redo unless within_range?(number)

      add_to_board(current_player.symbol, number)
      puts @board

      self.active = switch_active(active)
    end
  end

  private

  def within_range?(number)
    number.to_i < 9 && number.to_i >= 0
  end

  def switch_active(active_index)
    active_index.zero? ? 1 : 0
  end

  # just return -1 if no numbers in input
  def get_digit(number)
    digit = number.match(/\d+/)
    digit.nil? ? -1 : digit[0].to_i
  end

  def add_to_board(symbol, number)
    @board.place_symbol(symbol, number)
  end

  attr_accessor :active
end
