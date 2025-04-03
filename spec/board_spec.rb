require_relative '../lib/board'

describe Board do
  subject(:ttt_board) { described_class.create_board }

  describe '#match' do
    context 'when a winning pattern is horizontal' do
      it 'should return True' do
        symbol = :X
        pattern = {
          X: { row: [0, 0, 0], column: [0, 1, 2], diagonal_left: 0, diagonal_right: 0 },
          Y: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 }
        }
        subject.instance_variable_set(:@pattern, pattern)
        result = ttt_board.match?(symbol)
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
        result = ttt_board.match?(symbol)
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
        result = ttt_board.match?(symbol)
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
        result = ttt_board.match?(symbol)
        expect(result).to be_falsy
      end
    end
  end

  describe '#place_symbol' do
    context 'when a symbol is placed on first row number 2' do
      let(:num) { 2 }
      let(:empty_board) { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }
      before do
        index = { row: 0, column: 2 }
        allow(ttt_board).to receive(:get_index).with(num).and_return(index)
      end

      it 'should place that symbol at [[0, 1, HERE], [3, 4, 5], [6, 7, 8]]' do
        expect(ttt_board.board).to eq(empty_board)

        symbol = :X
        ttt_board.place_symbol(symbol, num)
        board_num_2 = [[0, 1, :X], [3, 4, 5], [6, 7, 8]]
        expect(ttt_board.board).to eq(board_num_2)
      end
    end

    context 'when a symbol is placed on the last row number 7' do
      let(:num) { 7 }

      before do
        index = { row: 2, column:  1 }
        allow(ttt_board).to receive(:get_index).with(num).and_return(index)
      end

      it 'should place that symbol at [[0, 1, 2], [3, 4, 5], [6, HERE, 8]]' do
        symbol = :X
        ttt_board.place_symbol(symbol, num)
        board_num_2 = [[0, 1, 2], [3, 4, 5], [6, :X, 8]]
        expect(ttt_board.board).to eq(board_num_2)
      end
    end
  end

  describe 'saving patterns on @pattern instance variable' do
    let(:empty_pattern) do
      {
        X: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 },
        Y: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 }
      }
    end
    let(:index) { { row: 0, column: 0 } }
    let(:symbol) { :X }

    describe '#save_horizontal_pattern' do
      context 'when a symbol is placed on 0' do
        it 'updates pattern row and column to add 0 on both' do
          pattern = ttt_board.instance_variable_get(:@pattern)
          expect(pattern).to eq(empty_pattern)

          ttt_board.save_horizonal_vertical(symbol, index)

          pattern = ttt_board.instance_variable_get(:@pattern)
          new_pattern = {
            X: { row: [0], column: [0], diagonal_left: 0, diagonal_right: 0 },
            Y: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 }
          }
          expect(pattern).to eq(new_pattern)
        end
      end
    end

    describe '#save_diagonal_left' do
      context 'when a symbol is placed on 0' do
        it 'updates pattern diagonal_left to 1' do
          pattern = ttt_board.instance_variable_get(:@pattern)
          expect(pattern).to eq(empty_pattern)

          ttt_board.save_diagonal_left(symbol, index)
          pattern = ttt_board.instance_variable_get(:@pattern)
          new_pattern = {
            X: { row: [], column: [], diagonal_left: 1, diagonal_right: 0 },
            Y: { row: [], column: [], diagonal_left: 0, diagonal_right: 0 }
          }
          expect(pattern).to eq(new_pattern)
        end
      end

      describe '#save_diagonal_right' do
        context 'when a symbol is placed on 0' do
          it 'does not update diagonal_right' do
            pattern = ttt_board.instance_variable_get(:@pattern)
            expect(pattern).to eq(empty_pattern)

            ttt_board.save_diagonal_right(symbol, index)
            pattern = ttt_board.instance_variable_get(:@pattern)
            expect(pattern).to eq(empty_pattern)
          end
        end
      end
    end
  end
end
