require './person'

class Student < Person
  attr_reader :classroom

  def initialize(age, classroom, name, parent_permission)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def classroom=(crm)
    @classroom = crm
    classroom.students.push(self) unless classroom.students.includes?(self)
  end
end
