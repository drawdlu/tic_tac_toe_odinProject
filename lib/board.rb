# frozen_string_literal: true

require_relative 'numbers'

# Board data
class Board
  include Numbers
  attr_accessor :board

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

  def place_symbol(symbol, number)
    index = get_index(number)
    @board[index[:row]][index[:column]] = symbol
  end

  def empty?(number)
    index = get_index(number)
    char = get_digit(@board[index[:row]][index[:column]].to_s)
    char != -1
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

  def get_index(number)
    row_index = number / 3
    column_index = number % 3

    { row: row_index, column: column_index }
  end
end
