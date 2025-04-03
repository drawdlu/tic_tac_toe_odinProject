require_relative '../lib/board'

describe Board do
  describe '#match' do
    subject(:board) { described_class.create_board }

    context 'when a winning pattern is horizontal' do
      it 'should return True' do
        symbol = :X
        pattern = {
          X: { row: [0, 0, 0], column: [0, 1, 2], diagonal_left: 0, diagonal_right: 0 },
          Y: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 }
        }
        subject.instance_variable_set(:@pattern, pattern)
        result = board.match?(symbol)
        expect(result).to be_truthy
      end
    end

    context 'when a winning pattern is vertical' do
      it 'should return True' do
        symbol = :X
        pattern = {
          X: { row: [0], column: [1, 1, 1], diagonal_left: 0, diagonal_right: 0 },
          Y: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 }
        }
        subject.instance_variable_set(:@pattern, pattern)
        result = board.match?(symbol)
        expect(result).to be_truthy
      end
    end

    context 'when a winning pattern is diagonal' do
      it 'should return True' do
        symbol = :X
        pattern = {
          X: { row: [0], column: [0, 1, 2], diagonal_left: 3, diagonal_right: 0 },
          Y: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 }
        }
        subject.instance_variable_set(:@pattern, pattern)
        result = board.match?(symbol)
        expect(result).to be_truthy
      end
    end

    context 'when there is no winning pattern' do
      it 'should return False' do
        symbol = :X
        pattern = {
          X: { row: [], column: [0, 1, 2], diagonal_left: 2, diagonal_right: 0 },
          Y: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 }
        }
        subject.instance_variable_set(:@pattern, pattern)
        result = board.match?(symbol)
        expect(result).to be_falsy
      end
    end
  end
end
