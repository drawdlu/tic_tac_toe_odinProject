# frozen_string_literal: true

require_relative 'numbers'

# Handle game loop
class Game
  include Numbers

  def initialize(player_set, board)
    @player_set = player_set
    @board = board
    @active = 0
  end

  def start
    puts @board

    loop do
      current_player = get_player(active)
      number = get_move(current_player)

      register_symbol(current_player.symbol, number)
      puts @board
      break if @board.match?(current_player.symbol)

      self.active = switch_active(active)
    end
    puts "#{get_player(active).name} has won the game!"
  end

  private

  attr_accessor :active

  def register_symbol(symbol, number)
    @board.place_symbol(symbol, number)
    @board.save_pattern(symbol, number)
  end

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

  def get_move(player)
    loop do
      prompt_input(player)
      number = get_digit(gets.chomp)
      return number if within_range?(number) && @board.empty?(number)
    end
  end
end
