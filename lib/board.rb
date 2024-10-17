# frozen_string_literal: true

require_relative 'numbers'

# Board data
class Board
  attr_accessor :board

  include Numbers

  def initialize(board)
    @board = board
  end

  def self.create_board(row, column)
    board = Array.new(row) { Array.new(column) }
    count = 0
    board.each do |arr|
      arr.map! do
        count += 1
        count - 1
      end
    end

    Board.new(board)
  end

  def add_value(symbol, number)
    row_index = number / 3
    column_index = number % 3
    @board[row_index][column_index] = symbol
  end

  def to_s
    print_line
    @board.each do |row|
      print '|'
      row.each do |symbol|
        print " #{symbol} "
        print '|'
      end
      puts ''
      print_line
    end
  end

  private

  def print_line
    13.times { print '-' }
    puts ''
  end
end
