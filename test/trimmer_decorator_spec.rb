require_relative '../trimmer_decorator'

describe TrimmerDecorator do
  context 'When testing the TrimmerDecorator class' do
    it 'The correct_name method should return a correct name' do
      trimmer_decorator = TrimmerDecorator.new('kero')
      expect(trimmer_decorator.correct_name('kero')).to eq 'Kero'
    end

    it 'The correct_name method should return a correct name' do
      trimmer_decorator = TrimmerDecorator.new('kero')
      expect(trimmer_decorator.correct_name('kerosamygrace')).to eq 'Kerosamygr'
    end
  end
end
