# frozen_string_literal: true

require_relative 'numbers'
require 'colorize'

# Board data
class Board
  include Numbers
  attr_accessor :board

  SIZE = 3

  def initialize(board)
    @board = board
    @pattern = {
      X: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 },
      Y: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 }
    }
  end

  def self.create_board
    board = Array.new(SIZE) { Array.new(SIZE) }
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

    save_horizonal_vertical(symbol, index)
    save_diagonal_left(symbol, index)
    save_diagonal_right(symbol, index)
  end

  def save_horizonal_vertical(symbol, index)
    @pattern[symbol][:row].push(index[:row])
    @pattern[symbol][:column].push(index[:column])
  end

  def save_diagonal_left(symbol, index)
    @pattern[symbol][:diagonal_left] += 1 if index[:row] == index[:column]
  end

  def save_diagonal_right(symbol, index)
    row = index[:row]
    column = index[:column]
    return unless row.zero? && column == 2 ||
                  row == 1 && column == 1 ||
                  row == 2 && column.zero?

    @pattern[symbol][:diagonal_right] += 1
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
    @pattern[symbol][:diagonal_left] == SIZE ||
      @pattern[symbol][:diagonal_right] == SIZE
  end

  def vertical_horizontal?(tally)
    tally.each_value do |value|
      return true if value == SIZE
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
      row.each do |element|
        print_colored(element)
        print '|'
      end
      puts ''
      print_line
    end
  end

  private

  def print_colored(element)
    if element == Player::SYMBOL[0]
      print " #{element} ".blue
    elsif element == Player::SYMBOL[1]
      print " #{element} ".red
    else
      print " #{element} ".yellow
    end
  end

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
