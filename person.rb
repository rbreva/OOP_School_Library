class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name: 'Unkown', parent_permission: true)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @id = rand(1...10)
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
end
