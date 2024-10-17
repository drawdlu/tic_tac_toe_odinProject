# frozen_string_literal: true

require_relative 'lib/player'
require_relative 'lib/player_set'
require_relative 'lib/board'

def player_names
  player1 = get_name(1)
  player2 = get_name(2)
  [player1, player2]
end

def get_name(number)
  length = 0
  while length < 1
    print "Enter player #{number} name: "
    name = gets.chomp
    length = name.length
  end
  name
end

# get names and initialize game
names = player_names
player_set = PlayerSet.new
board = Board.create_board(3, 3)
Player.new(names[0], player_set)
Player.new(names[1], player_set)
puts board
