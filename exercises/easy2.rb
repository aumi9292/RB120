# frozen_string_literal: true

module Mailable
  def print_address
    puts name.to_s
    puts address.to_s
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new
bob = Employee.new
betty.print_address
bob.print_address

module Drivable
  def drive
    puts "I'm driving!"
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive

class House
  attr_reader :price
  include Comparable
  def initialize(price)
    @price = price
  end

  def <=>(other)
    if price > other.price
      1
    elsif price == other.price
      0
    elsif price < other.price
      -1
    end
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts 'Home 1 is cheaper' if home1 < home2
puts 'Home 2 is more expensive' if home2 > home1

class Transform
  attr_accessor :str

  def initialize(str)
    @str = str
  end

  def uppercase
    str.upcase
  end

  def self.lowercase(str)
    str.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected

  attr_reader :amount
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end

class Pet
  attr_accessor :name, :species
  def initialize(species, name)
    @species = species
    @name = name
  end
end

class Owner
  attr_accessor :pets, :name, :number_of_pets
  def initialize(name)
    @name = name
    @pets = []
    @number_of_pets = 0
  end
end

class Shelter
  attr_accessor :client_list, :animals_to_adopt
  def initialize
    @client_list = {}
    @animals_to_adopt = []
  end

  def add_animal_to_shelter(pet_species, pet_name)
    animals_to_adopt << [pet_species, pet_name]
  end

  def adopt(owner, pet)
    owner.pets << [pet.name, pet.species]
    client_list[owner.name] = owner.pets
    owner.number_of_pets += 1
  end

  def print_adoptions
    client_list.each do |owner, pets|
      puts "#{owner} has adopted the following pets: "
      pets.each do |pet|
        puts "A #{pet[1]} named #{pet[0]}"
      end
    end
  end

  def print_available
    puts 'The Animal Shleter has the following unadopted pets: '
    animals_to_adopt.each do |set|
      puts "A #{set[0]} named #{set[1].capitalize}"
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin = Pet.new('bearded dragon', 'Darwin')
kennedy = Pet.new('dog', 'Kennedy')
sweetie = Pet.new('parakeet', 'Sweetie Pie')
molly = Pet.new('dog', 'Molly')
chester = Pet.new('fish', 'Chester')
soda = Pet.new('soda fish', 'soda')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')
amiller = Owner.new('A Miller')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.adopt(amiller, soda)
shelter.add_animal_to_shelter('dragon', 'norbert')
shelter.add_animal_to_shelter('dragon', 'ergaon')
shelter.add_animal_to_shelter('dragon', 'smaug')
shelter.print_available
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin
#
# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester
#
# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    @string * 3
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander

module Movable
  def walk
    puts "#{self} #{gait} forward"
  end
end

class Noble
  attr_reader :name, :title
  include Movable

  def initialize(name, title)
    @name = name
    @title = title
  end

  def to_s
    "#{title} #{name}"
  end

  private

  def gait
    'struts'
  end
end

class Person
  include Movable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name.to_s
  end

  private

  def gait
    'strolls'
  end
end

class Cat
  attr_reader :name
  include Movable
  def initialize(name)
    @name = name
  end

  def to_s
    name.to_s
  end

  private

  def gait
    'saunters'
  end
end

class Cheetah
  attr_reader :name
  include Movable
  def initialize(name)
    @name = name
  end

  def to_s
    name.to_s
  end

  private

  def gait
    'runs'
  end
end

mike = Person.new('Mike')
mike.walk
# => "Mike strolls forward"

kitty = Cat.new('Kitty')
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new('Flash')
flash.walk
# => "Flash runs forward"

byron = Noble.new('Byron', 'Lord')
p byron.walk
