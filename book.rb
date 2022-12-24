class Book
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def add_rental(date, person)
    @rentals.push(Rental.new(date, self, person))
  end
end
