# How do we create an object in Ruby? Give an example of the creation of an object.

# Create a class, call ::new on the class
module Movable
  def move
    puts "I'm walking"
  end
end

class Person
  include Movable
  def initialize(name)
    @name = name
  end

  def to_s
    @name
  end
end

bob = Person.new('Bob')
puts bob

# What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

# A module is a set of grouped constants, classes, and methods. Objects cannot be made from modules, but modules give shared functionality and data to classes that do not necessarily inherit from one another.

class Lizard
  include Movable
end

bob.move
Lizard.new.move

# Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.
class MyCar
  attr_accessor :speed, :color
  attr_writer :year

  def initialize(year, color, model)
    @year = year
    @model = model
    @color = color
    @speed = 0
  end

  def speed_up
    self.speed += 10
  end

  def slow_down
    self.speed -= 2
  end

  def shut_off
    self.speed = 0
  end
end

white_rascal = MyCar.new(2003, 'white', 'Accent')
p white_rascal.speed
white_rascal.speed_up
p white_rascal.speed
white_rascal.slow_down
p white_rascal.speed
white_rascal.shut_off
p white_rascal.speed

class Animal
  def move
    "I'm moving"
  end
end

class Snake < Animal
  def move
    super + "by slithering"
  end
end

puts Snake.new.is_a?(Animal)

# lesson 2

class Person
  attr_reader :first_name
  attr_accessor :last_name

  def initialize(name)
    @first_name = name.split(' ').first
    @last_name = name.split(' ').length == 1 ? '' : name.split(' ').last
  end

  def name
    (@first_name + ' ' + @last_name).rstrip
  end

  # def name=(name)
  #   name.split(' ').length == 1 ? @first_name = name : [@first_name, @last_name] = name.split(' ')
  # end
end
bob = Person.new('Robert')
puts bob.name                  # => 'Robert'
puts bob.first_name            # => 'Robert'
puts bob.last_name             # => ''
puts bob.last_name = 'Smith'
puts bob.name                  # => 'Robert Smith'

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# p bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

# p bob.name = "John Adams"
# p bob.first_name            # => 'John'
# p bob.last_name             # => 'Adams'
class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def ==(other)
    name == other.name
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.name == rob.name
p bob == rob

class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def speak
    'bark!'
  end
end

class Dog < Animal
  CON = false
  attr_reader :move

  @@teeth = 32

  def initialize
    @move = true
    puts defined? @@teeth
  end

  def swim
    'swimming!'
  end

  puts defined? CON

  def fetch
    'fetching!'
  end
end

class Cat < Animal
end

teddy = Dog.new
puts teddy.speak # => "bark!"
puts teddy.swim

class BullDog < Dog
  def swim
    "can't swim!"
  end
end

x = 10
puts defined? x
puts defined? Dog::CON
puts defined? Dog.new.move
puts defined? Dog.teeth
puts defined? []

module GreenTechnology
  def enable_solar_powered_rooftops
    @solar = true
  end
end

class City
  attr_accessor :carbon_emissions, :solar

  include GreenTechnology

  def initialize
    @population = 0
    @carbon_emissions = 100
  end

  def cut_carbon_emissions
    self.carbon_emissions -= 10 if @solar
  end
end

p nyc = City.new
p nyc.carbon_emissions
p nyc.enable_solar_powered_rooftops
p nyc.solar
p nyc.cut_carbon_emissions

module Maintenance
  def change_tires
    "Changing #{self.class::WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
end

a_car = Car.new
a_car.change_tires

cell = "single-celled"

class Life
  attr_accessor :form

  def initialize(form)
    @form = form
  end
end

mitochondria = Life.new(cell)

cell.delete!('e')

p mitochondria

class Greeting
  def greet(str)
    puts str
  end
end

class Hello < Greeting
  def hi
    greet("hello")
  end
end

class Goodbye < Greeting
  def bye
    greet('goodbye')
  end
end

class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type || 'Plain'
    @glazing = glazing
  end

  def to_s
    @glazing ? "#{@filling_type} with #{@glazing}" : @filling_type.to_s
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
#=> "Plain"

puts donut2
#=> "Vanilla"

puts donut3
# => "Plain with sugar"

puts donut4
#=> "Plain with chocolate sprinkles"

puts donut5
#=> "Custard with icing"


# class SecretFile
  
#   def initialize(secret_data, log)
#     @data = secret_data
#     @log = log
#   end

#   def data 
#     log.create_log_entry
#     @data
#   end 

#   private
#   attr_reader :log
# end

# class SecurityLogger
#   def create_log_entry
#     # ... implementation omitted ...
#   end
# end

module Movable 
  attr_accessor :speed, :heading 
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency + 10 if self.superclass == Boat 
  end
end 

class WheeledVehicle
  include Movable
  attr_accessor :speed, :heading

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Boat 
  include Movable
  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
  end
end 

class Catamaran < Boat 

end

class Motorboat < Boat 
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
end 