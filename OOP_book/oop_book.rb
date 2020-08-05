# frozen_string_literal: true

module Clean
  def clean(type)
    puts "#{type}ing done!"
  end
end

class Street
  include Clean
end

broadway = Street.new

p broadway

# create an object in Ruby using the new method invocation
# e.g., my_hash = Hash.new

p broadway.clean('Streetsweep')
p broadway.class.ancestors

class Cities
  attr_reader :longest_street

  def initialize(name)
    @name = name
    @population = rand(1_000_000)
    @tallest_building = rand(100)
    @longest_street = %w[Broadway Park Colfax Downing Olive].sample
  end

  def info
    "This city has a population of #{@population} people. The longest street is #{@longest_street}"
  end

  def to_s
    @name
  end
end

denver = Cities.new('Denver')

p denver.info
p denver.to_s
p denver.longest_street

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info # => Sparky weighs 10 lbs and is 12 inches tall.

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info

class Vehicle
  @@number_of_vehicles = 0

  attr_accessor :speed, :color, :model
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_vehicles += 1
  end

  def self.mileage(miles, gallons)
    (miles / gallons).to_s
  end

  def self.number_of_vehicles
    "There are #{@@number_of_vehicles} in the world"
  end

  def go_faster
    self.speed += 10
  end

  def slow_down
    self.speed -= 5
  end

  def hyperdrive
    self.speed += 1000
  end

  def stop
    self.speed = 0
  end

  def check_speed
    self.speed
  end

  def spraypaint(new_color)
    self.color = new_color
  end

  protected

  def age; end
end

class MyCar < Vehicle
  TYPE = 'car'
  def to_s
    "My car is a #{model}"
  end
end

module Loadable
  def add_to_bed(item)
    "The #{item} has been added to the bed of the truck"
  end
end

class MyTruck < Vehicle
  include Loadable
  TYPE = 'Truck'
end

beluga = MyCar.new(2008, 'blue', 'Honda Fit')
trucky = MyTruck.new(2010, 'red', 'Ford Durgano')
p trucky.hyperdrive
p trucky.add_to_bed('bedframe')
p trucky.class::TYPE
p beluga.go_faster
p beluga.check_speed
p beluga.go_faster
p beluga.hyperdrive
p beluga.slow_down
p beluga.color
p beluga.color = 'red'
p beluga
p beluga.year
p beluga.spraypaint('purple')
p beluga
p beluga.class.mileage(100, 30)
p beluga.to_s
p Vehicle.number_of_vehicles
p beluga.class.ancestors
p trucky.class.ancestors
# class GoodDog
#   attr_accessor :name, :height, :weight

#   def initialize(n, h, w)
#     self.name   = n
#     self.height = h
#     self.weight = w
#   end

#   def change_info(n, h, w)
#     self.name   = n
#     self.height = h
#     self.weight = w
#   end

#   def info
#     "#{name} weighs #{weight} and is #{height} tall."
#   end

#   def what_is_self
#     self
#   end
# end

# rocky = GoodDog.new('rocky', 150, 10)

# p rocky.what_is_self

class Student
  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(st1)
    grade > st1.grade
  end

  protected

  attr_reader :grade
end

bob = Student.new('Bob', 85)
p bob
gary = Student.new('gary', 90)

p gary.better_grade_than?(bob)
