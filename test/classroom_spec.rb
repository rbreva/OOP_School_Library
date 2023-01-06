require_relative '../classroom'
require_relative '../student'

describe Classroom do
  context 'When testing the Classroom class' do
    it 'The initialize method should return create new Classroom object' do
      classroom = Classroom.new(1)
      expect(classroom.label).to be 1
    end

    it 'The add_student method should add student to the classroom' do
      classroom = Classroom.new(1)
      student = Student.new(16, nil, 'kero', true)
      classroom.add_student(student)
      expect(classroom.students.length).to eq(2)
    end
  end
end
