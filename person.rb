require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @age = age
    @name = name
    @parent_permission = parent_permission
    @id = Random.rand(1...1000)
    @rentals = []
  end

  private

  def of_age?(age)
    true if age >= 18
    false
  end

  public

  def can_use_services?
    return true if of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rentals(rental)
    @rentals.push(rental)
  end
end
