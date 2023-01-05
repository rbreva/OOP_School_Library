require 'json'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  def initialize
    @books = load_books
    @person = load_people
    @rentals = load_rentals

    # @books = []
    # @person = []
    # @rentals = []
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

  # def list_people
  #   puts "\n List of People \n\n"
  #   @person.each do |per|
  #     if per.instance_of?(Teacher)
  #       puts "[teacher]: [Name: #{per.name}, specialization: #{per.specialization}, ID: #{per.id}, Age: #{per.age}"
  #     else
  #       puts "[student]: [Name: #{per.name}, PP: #{per.parent_permission}, ID: #{per.id}, Age: #{per.age}"
  #     end
  #     puts "\n"
  #   end
  # end

  def list_people
    puts "\n List of People \n\n"
    @person.each_with_index do |per, index|
      if per.instance_of?(Teacher)
        puts "#{index}>[teacher]: [Name: #{per.name}, specialization: #{per.specialization}, ID: #{per.id}, Age: #{per.age}"
      else
        puts "#{index}>[student]: [Name: #{per.name}, PP: #{per.parent_permission}, ID: #{per.id}, Age: #{per.age}"
      end
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
      @person.push(Teacher.new(age, specialty, name))
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
    puts @person[iam - 1].name
    print 'Date:'
    date = gets.chomp

    p_index = iam - 1
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

  def save_data
    save_people
    save_books
    save_rentals
  end

  def check_type(per)
    return 'teacher' if per.instance_of?(Teacher)

    'student'
  end

  def save_people
    # puts "save_people"
    File.open('people.json', 'w') do |file|
      people = @person.each_with_index.map do |per, index|
        { type: check_type(per),
          name: per.name,
          age: per.age,
          specialization: (per.specialization if per.instance_of?(Teacher)),
          parent_permission: per.parent_permission,
          index: index,
          id: per.id }
      end
      file.write(JSON.generate(people))
    end
  end

  def save_books
    # puts "save_books"
    File.open('books.json', 'w') do |file|
      books = @books.each_with_index.map do |book, index|
        {
          title: book.title, author: book.author, index: index
        }
      end
      file.write(JSON.generate(books))
    end
  end

  def save_rentals
    File.open('rentals.json', 'w') do |file|
      rentals = @rentals.each_with_index.map do |rental, _index|
        {
          date: rental.date, book_index: @books.index(rental.book),
          person_index: @person.index(rental.person)
        }
      end
      file.write(JSON.generate(rentals))
    end
  end

  def load_people
    return [] unless File.exist?('people.json')

    people_json = JSON.parse(File.read('people.json'))
    people_json.map do |per|
      if per['type'] == 'teacher'
        Teacher.new(per['age'], per['specialization'], per['name'])
      else
        # per.specialization
        Student.new(per['age'], @classroom, per['name'], per['parent_permission'])
      end
    end
  end

  def load_books
    return [] unless File.exist?('books.json')

    books_json = JSON.parse(File.read('books.json'))
    books_json.map do |book|
      Book.new(book['title'], book['author'])
    end
  end

  def load_rentals
    return [] unless File.exist?('rentals.json')

    rentals_json = JSON.parse(File.read('rentals.json'))
    rentals_json.map do |rental|
      Rental.new(rental['date'], @books[rental['book_index']], @person[rental['person_index']])
    end
  end

  def exit_app
    puts "\n Thank you for using this app! \n\n"
    # puts "save and exit the application"
    save_data
    exit(true)
  end
end
