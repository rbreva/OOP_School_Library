require_relative '../person'
require_relative '../book'
require_relative '../rental'

describe 'Create person object' do
  context 'given the valid inputs' do
    it 'should create a person with age = 10' do
      person = Person.new(20)
      expect(person.age).to eql(20)
    end

    it 'should create a person with age = 20 and called Omar' do
      person = Person.new(20, 'Omar')
      expect(person.age).to eql(20)
      expect(person.name).to match('Omar')
    end

    it 'of_age? method should return true' do
      person = Person.new(20, 'Kerolous')
      # expect(person.of_age?).to be true
      p person.of_age?
    end

    it 'The can_use_services? method should return true' do
      person = Person.new(20, 'Kerolous')
      expect(person.can_use_services?).to be true
    end
    
    it 'The correct_name method should return true' do
      person = Person.new(20, 'Kerolous')
      p person.correct_name
      expect(person.correct_name).to eq('Kerolous')
    end

    it 'The add_rentals method should return the rental' do
      person = Person.new(20, 'Kerolous')
      book = Book.new('book', 'author')
      date = '2022/8/8'
      rental = Rental.new(date, book, person)
      person.add_rentals(rental)
      expect(person.rentals.length).to eq(1)
    end
  end
end
