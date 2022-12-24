class Rental
  attr_reader :person, :book
  attr_writer :date

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    @book.rentals.push(self)
    @person.rentals.push(self)
  end
end
