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

    it 'The can_use_services? method should return true' do
      person = Person.new(20, 'Kerolous')
      expect(person.can_use_services?).to be true
    end
  end
end
