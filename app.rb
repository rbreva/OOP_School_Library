require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  def initialize
    @books = []
    @person = []
    @rentals = []
  end

  # rubocop:disable Style/CyclomaticComplexity
  def select_opt
    option = gets.chomp.to_i
    case option
    when 1 then list_books
    when 2 then list_people
    when 3 then create_person
    when 4 then create_book
    when 5 then create_rental
    when 6 then list_rentals
    when 7 then exit_app
    else
      puts 'PLEASE ENTER A NUMBER (1..7)'
    end
  end
  # rubocop:enable Style/CyclomaticComplexity

  def list_books
    puts "\n List of Books \n\n"
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
      puts "\n"
    end
  end

  def list_people
    puts "\n List of People \n\n"
    @person.each do |p|
      puts "[#{p.class.name}] Name: #{p.name}, ID: #{p.id}, Age: #{p.age}"
      puts "\n"
    end
  end

  def options_person(msg, options)
    number = 0
    loop do
      print msg
      input = gets.chomp.to_i
      if options.include?(input)
        number = input
        break
      else
        puts 'Please, enter a valid input!'
      end
    end
    number
  end

  def verify_number(msg)
    number = 0
    loop do
      print msg
      input = gets.chomp.to_i
      if input.is_a?(Integer) && input.positive?
        number = input
        break
      else
        puts 'Please, enter a valid input!'
      end
    end
    number
  end

  def check_permission(permission)
    case permission
    when 'y' then permission = true
    when 'n' then permission = false
    end
    permission
  end

  def create_person
    puts "\n Create a Person \n\n"
    num = options_person('Do you want to create a student (1) or a teacher (2)? [input the number]: ', [1, 2])
    age = verify_number('Age:')

    print 'name:'
    name = gets.chomp
    classroom = 1

    case num
    when 1
      print 'Has parent permission? [y/n]:'
      permission = gets.chomp

      permission = check_permission(permission)

      @person.push(Student.new(age, classroom, name, permission))
    when 2
      print 'Specialization:'
      specialty = gets.chomp

      @person.push(Teacher.new(age, specialty, name: name))
    else
      puts 'Invalid number, please enter number again!'
    end
    puts "\n Person created successfully \n"
  end

  def create_book
    puts "\n Create a Book \n\n"
    print 'Title:'
    title = gets.chomp
    print 'author:'
    author = gets.chomp
    @books.push(Book.new(title, author))
    puts 'Book Created Successfully'
  end

  def create_rental
    puts "\n Create Rental \n\n"

    puts 'Select a book from the following list'
    @books.each_with_index do |book, index|
      puts "#{index + 1}) Title: #{book.title}, Author: #{book.author}"
    end
    book_num = gets.chomp.to_i

    puts 'Select a person from the following list'
    @person.each_with_index do |per, index|
      puts "No: #{index + 1}, [#{per.class}] Name: #{per.name}, ID: #{per.id}, Age: #{per.age}"
    end
    puts @person[0].name
    iam = gets.chomp.to_i
    puts iam
    puts "HERE #{@person[iam - 1].name}"
    puts @person[iam - 1].name
    print 'Date:'
    date = gets.chomp

    p_index = iam - 1
    p @person[p_index]
    @rentals.push(Rental.new(date, @books[book_num - 1], @person[p_index]))
    puts 'Rental Created successfully'
  end

  def list_rentals
    puts "\n lista de Rental \n\n"

    puts "\nKindly enter the ID of the person:\n\n"
    id = gets.chomp
    id = id.to_i

    puts "\nRentals\n\n"

    @rentals.each do |rental|
      puts rental.person
      puts "\nDate: #{rental.date} Book: #{rental.book.title} by #{rental.book.author}" if rental.person.id == id
    end
  end

  def exit_app
    puts "\n Thank you for using this app! \n\n"
    exit(true)
  end
end
