require_relative './person'

class Teacher < Person
  attr_reader :specialization

  def initialize(age, specialization, name, parent_permission: true)
    puts "HERE #{name}"
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def teach_stuff
    'Everything'
  end
end
