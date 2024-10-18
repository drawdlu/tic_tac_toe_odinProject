# frozen_string_literal: true

require_relative 'numbers'

# Board data
class Board
  include Numbers
  attr_accessor :board

  def initialize(board)
    @board = board
    @pattern = {
      X: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 },
      Y: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 }
    }
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

  def save_pattern(symbol, number)
    index = get_index(number)

    # for vertical or horizontal
    @pattern[symbol][:row].push(index[:row])
    @pattern[symbol][:column].push(index[:column])

    # for digonal from top left
    @pattern[symbol][:diagonal_left] += 1 if index[:row] == index[:column]

    # for diagonal from top right
    save_diagonal_right(symbol, index)
  end

  def match?(symbol)
    row_tally = @pattern[symbol][:row].tally
    column_tally = @pattern[symbol][:column].tally

    straight_line?(row_tally, column_tally) || diagonal?(symbol)
  end

  def straight_line?(row_tally, column_tally)
    vertical_horizontal?(row_tally) || vertical_horizontal?(column_tally)
  end

  def diagonal?(symbol)
    @pattern[symbol][:diagonal_left] == 3 ||
      @pattern[symbol][:diagonal_right] == 3
  end

  def save_diagonal_right(symbol, index)
    row = index[:row]
    column = index[:column]
    return unless row.zero? && column == 2 ||
                  row == 1 && column == 1 ||
                  row == 2 && column.zero?

    @pattern[symbol][:diagonal_right] += 1
  end

  def vertical_horizontal?(tally)
    tally.each_value do |value|
      return true if value == 3
    end
    false
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
