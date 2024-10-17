# frozen_string_literal: true

# Board data
class Board
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
    @board[number / 3][number % 3] = symbol
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

  attr_accessor :board

  def print_line
    13.times { print '-' }
    puts ''
  end
end
