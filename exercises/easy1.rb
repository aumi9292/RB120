# frozen_string_literal: true

class Banner
  def initialize(message, width = message.length + 2)
    @message = message
    @width = width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  attr_accessor :message, :width

  def horizontal_rule
    message.length < width ? '+' + '-' * width + '+' : '+' + '-' * (message.length + 2) + '+'
  end

  def empty_line
    message.length < width ? '|' + ' ' * width + '|' : '|' + ' ' * (message.length + 2) + '|'
  end

  def message_line
    "| #{message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 4)
puts banner
banner2 = Banner.new('')
puts banner2

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name.dup)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
puts
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

puts
puts

class Book
  attr_accessor :author, :title
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new('Neil Stephenson', 'Snow Crash')
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

class Person
  attr_writer :first_name, :last_name
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def to_s
    "#{@first_name.capitalize} #{@last_name.capitalize}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person

class Flight
  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end

  protected

  attr_accessor :database_handle
end

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    # total = mileage + miles
    # mileage = total
    self.mileage += miles
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage # should print 5678

class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
  def initialize(side)
    @side = side
    super(side, side)
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"

class Pet
  def initialize(name, age, color = nil)
    @name = name
    @age = age
    @color = color
  end
end

class Cat < Pet
  # def initialize(name, age, color)
  #   super(name, age)
  #   @color = color
  # end

  def to_s
    "My cat #{name} is #{age} years old and has #{color} fur."
  end

  private

  attr_reader :name, :age, :color
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

class Vehicle
  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end

  private

  attr_reader :make, :model
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end
