# frozen_string_literal: true

# # frozen_string_literal: true

# class Person
#   attr_accessor :last_name, :first_name, :name

#   def initialize(name)
#     @name = name
#     @first_name, @last_name = name.split(' ') if name.split(' ').length > 1
#   end

#   # def name
#   #   first_name + ' ' + last_name
#   # end
# end

# p bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# p bob.last_name = 'Smith'
# p bob.name

# 2nd run through
# class Person
#   def initialize(name)
#     @name = name
#   end

#   attr_reader :name

#   attr_writer :name
# end
# p bob = Person.new('bob')
# p bob.name # => 'bob'
# p bob.name = 'Robert'
# p bob.name

# 2.

class Person
  attr_accessor :last_name
  attr_reader :first_name

  def initialize(name)
    if name.split(' ').length > 1
      @first_name, @last_name = name.split(' ')
    else
      @first_name = name
      @last_name = ''
    end
  end

  def name
    "#{@first_name} #{@last_name}".strip
  end
end

p bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name

# 3

# 4 create a way so that Person objects can be compared by the acsibetal values of their characters--more simply, compare the strings

# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     check_name(full_name)
#   end

#   def to_s
#     name.to_s
#   end

#   def name
#     "#{@first_name} #{@last_name}".strip
#   end

#   def name=(n)
#     check_name(n)
#   end

#   def ==(other)
#     name == other.name
#   end

#   private

#   def check_name(full_name)
#     if full_name.split.length > 1
#       @first_name, @last_name = full_name.split
#     else
#       @first_name = full_name
#       @last_name = ''
#     end
#   end
# end

# p bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# p bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

# p bob.name = 'John Adams'
# p bob.first_name            # => 'John'
# p bob.last_name

# p bob = Person.new('Robert Smith')
# p rob = Person.new('Robert Smith')

# p bob == rob
# p rob.to_s

# Inheritance Lecture

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class BullDog < Dog
  def swim
    "Can't swiM!"
  end
end

teddy = Dog.new
puts teddy.speak # => "bark!"
puts teddy.swim # => "swimming!"
bully = BullDog.new
p bully.swim

# 2 create a cat class

module Animable
  def speak
    'bark!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Cat
  include Animable
end

class Dog
  include Animable

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

p Cat.instance_methods

class Wedding
  attr_reader :guests, :flowers, :songs

  def initialize(guests, flowers, songs)
    @guests = guests
    @flowers = flowers
    @songs = songs
  end

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    # implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    # implementation
  end
end

miller_wedding = Wedding.new(100, 'roses', 'love song')

module Preparers
end

class Person
  def initialize
    @heroes = %w[Superman Spiderman Batman]
    @cash = { 'ones' => 12, 'fives' => 2, 'tens' => 0, 'twenties' => 2, 'hundreds' => 0 }
  end

  def cash_on_hand
    @cash.map do |k, v|
      case k
      when 'ones' then v * 1
      when 'fives' then v * 5
      when 'tens' then v * 10
      when 'twenties' then v * 20
      when 'hundreds' then v * 100
      end
    end.sum
  end

  def heroes
    @heroes.join(', ')
  end
end

joe = Person.new
p joe.cash_on_hand # => "$62.00"
p joe.heroes

class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "Can't swiM!"
  end
end

bob = Person.new('Robert')
bud = Bulldog.new # assume Bulldog class from previous assignment
fido = Bulldog.new             # assume Bulldog class from previous assignment
lili = Bulldog.new             # assume Bulldog class from previous assignment

bob.pets << bud << fido << lili
p bob.pets
