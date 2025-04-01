require_relative '../lib/numbers'

describe 'Numbers module' do
  let(:numbers) { Class.new { extend Numbers } }

  describe '#get_digit' do
    context 'when a digit is entered' do
      it 'returns the digit' do
        value = '3'
        expect(numbers.get_digit(value)).to eq(3)
      end
    end

    context 'when no numbers are input' do
      it 'returns -1' do
        value = 'dfd'
        expect(numbers.get_digit(value)).to eq(-1)
      end
    end

    context 'when both numbers and non numbers are input' do
      it 'returns only the number' do
        value = 'dfd4'
        expect(numbers.get_digit(value)).to eq(4)
      end
    end
  end
end
