require_relative 'app'

def print_interface
  puts "Please choose an option by enterin a number:
    1 - List all books
    2 - List all people
    3 - Create a person
    4 - Create a book
    5 - Create a rental
    6 - List all rentals for a given person id
    7 - Exit"
end

class Main
  app = App.new
  print "Welcome to library Application! \n \n"
  loop do
    print_interface
    selected = app.select_opt
    selected
  end
end
