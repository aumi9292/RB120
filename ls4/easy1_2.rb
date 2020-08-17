module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Vehicle
  include Speed
end

class Car < Vehicle
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck < Vehicle
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

p Car.new.go_fast

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end
pep = Pizza.new('pep')
p pep.instance_variables
p pep.class.instance_variables

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

bag1 = Bag.new('red', 'burlap')
bag2 = Bag.allocate

p bag1
p bag2

# easy2

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
p oracle.choices
p oracle.choices
p oracle.choices

# easy 3
# 1.
# 1- 'hello' will be output to the screen
# 2- NoMethodError bye for Hello class
# 3-ArgumentError expected 1 argument given 0
# 4-'goodbye' will be output to the screen
# 5- NoMethodError--no method hi for class Hello

class Greeting
  def self.greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

Hello.hi

# medium 1
class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

class Greeting
  def greet(str)
    puts str
  end
end

class Hello < Greeting
  def hi
    "Hello"
  end
end

class Goodbye < Greeting
  def bye
    "Goodbye"
  end
end

Greeting.new.greet(Hello.new.hi)
Greeting.new.greet(Goodbye.new.bye)

class KrispyKreme
  attr_accessor :filling_type, :glazing

  def initialize(filling_type = nil, glazing = nil)
    @filling_type = filling_type
    @glazing = glazing
  end

  def convert_to_default
    self.filling_type = 'Plain' if filling_type.nil?
  end

  def to_s
    convert_to_default
    if glazing
      "#{filling_type} with #{glazing}"
    else
      (filling_type).to_s
    end
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
# => "Plain"

puts donut2
# => "Vanilla"

puts donut3
# => "Plain with sugar"

puts donut4
#  => "Plain with chocolate sprinkles"

puts donut5
#  => "Custard with icing"

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    template
  end
end

class Light
  attr_reader :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def to_s
    "I have a brightness level of #{brightness} and a color of #{color}"
  end
end

puts Light.new('100%', 'purple')

# hard

class SecurityLogger
  attr_reader :log

  def initialize
    @log = []
  end

  def create_log_entry
    log << Time.now
  end
end

class SecretFile
  attr_reader :data_log

  @@data_log = SecurityLogger.new

  def initialize(secret_data)
    @data = secret_data
  end

  def data
    data_log.create_log_entry
    @data
  end

  def data_log
    @@data_log
  end
end

secrets = SecretFile.new('shh')
p secrets.data
p secrets.data
p secrets.data_log

lies = SecretFile.new('myth')
p lies.data
p lies.data_log
p secrets.data_log

# 2

# module Movable
#   attr_accessor :speed, :heading, :fuel_capacity, :fuel_efficiency

#   def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
#     @fuel_efficiency = km_traveled_per_liter
#     @fuel_capacity = liters_of_fuel_capacity
#   end

#   def range
#     @fuel_capacity * @fuel_efficiency
#   end
# end

# class WheeledVehicle
#   include Movable
#   attr_accessor :speed, :heading

#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     @tires = tire_array
#     super(km_traveled_per_liter, liters_of_fuel_capacity)
#   end

#   def tire_pressure(tire_index)
#     @tires[tire_index]
#   end

#   def inflate_tire(tire_index, pressure)
#     @tires[tire_index] = pressure
#   end
# end

# class Auto < WheeledVehicle
#   def initialize
#     # 4 tires are various tire pressures
#     super([30, 30, 32, 32], 50, 25.0)
#   end
# end

# class Motorcycle < WheeledVehicle
#   def initialize
#     # 2 tires are various tire pressures
#     super([20, 20], 80, 8.0)
#   end
# end

# class Catamaran
#   include Movable
#   attr_reader :propeller_count, :hull_count
#   attr_accessor :speed, :heading

#   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#     @propeller_count = num_propellers
#     @hull_count = num_hulls
#     super(km_traveled_per_liter, liters_of_fuel_capacity)
#   end
# end

# boat = Catamaran.new(4, 2, 25, 100)
# car = WheeledVehicle.new([100, 30, 20, 4], 50, 10)
# p boat
# p boat.class
# p car
# p car.class
# puts
# p car.fuel_capacity

# class Motorboat
#   include Movable
#   attr_reader :propeller_count, :hull_count
#   attr_accessor :speed, :heading

#   def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
#     @propeller_count = 1
#     @hull_count = 1
#     super(km_traveled_per_liter, liters_of_fuel_capacity)
#   end
# end

# boaty = Motorboat.new(50, 1000)
# p boaty.range

module Movable
  attr_accessor :speed, :heading, :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Movable
  attr_accessor :speed, :heading

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
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
    super([30, 30, 32, 32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20, 20], 80, 8.0)
  end
end

class SeaVehicle
  include Movable
  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def range
    (@fuel_capacity * @fuel_efficiency) + 10
  end
end
class Catamaran < SeaVehicle
end

class Motorboat < Catamaran
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

car2 = WheeledVehicle.new([5, 5, 5, 5], 50, 10)
p car2.range
boat2 = Catamaran.new(4, 2, 100, 99)
p boat2.fuel_efficiency
moto = Motorboat.new(400, 10)
p moto.range
p moto.hull_count
