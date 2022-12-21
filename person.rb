class Person
  attr_accessor :name, :age, :id

  def initialize(age, name: 'Unkown', parent_permission: true)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  private

  def of_age?(age)
    true if age >= 18
    false
  end

  public

  def can_use_services?
    return true if is_of_age? || @parent_permission
  end
end
