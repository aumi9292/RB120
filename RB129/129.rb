CONST = ' out there'
class Inside_one
  CONST = proc { ' in there' }
  def where_is_my_CONST
    ::CONST + ' inside one'
  end
end
class Inside_two
  CONST = ' inside two'
  def where_is_my_CONST
    CONST
  end
end
puts Inside_one.new.where_is_my_CONST # 'out there inside one'
puts Inside_two.new.where_is_my_CONST # ' inside two'
puts Object::CONST + Inside_two::CONST # 'out there inside two'
puts Inside_two::CONST + CONST # inside two out there
puts Inside_one::CONST # 'proc {in there}'
puts Inside_one::CONST.call + Inside_two::CONST # ' in there inside two'

# yue's tips
class Ancestors
  def bob
    self
  end

  def self.hello
    "#{ancestors[2]} class"
  end
end

class Humans < Ancestors
  def hello
    "ancestors class"
  end
end

class Persons < Humans
  def who_am_i
    puts "I am the #{bob.class.hello}"
    # I am the ancestors class
  end
end

bob = Persons.new
bob.who_am_i

p 'Mississippi'.scan(/i/).length
p 'Mississippi'.match?(/ss/)

module Hikable
  def hike
    puts "I hiked the #{mount}!"
  end

  def self.mount
    "mountain"
  end
end

class Mountains
  include Hikable
end

Mountains.new
p Hikable.mount

class Dog
  # attr_reader :nickname

  def initialize(n)
    @nickname = n
  end

  def change_nickname(n)
    self.nickname = n
  end

  def greeting
    "#{nickname.capitalize} says Woof Woof!"
  end

  private

  attr_accessor :nickname
end

p dog = Dog.new("rex")
p dog.change_nickname("barny")
p dog

class Painting
  def initialize
    @image = 'belle'
  end

  def change_image
    self.image = "beautiful"
  end

  private

  attr_accessor :image
end

p Painting.new.change_image

class Coffee
  ROAST = 'light'
end

class Decaf
  ROAST = ::Coffee::ROAST
end

p Decaf::ROAST

# class Coffee
#   ROAST = 'light'
# end
# class Decaf
#   puts Coffee::ROAST
# end

puts "hello\rgood"
puts "hello\ngood"

class Building
  def initialize(address, stories = 1)
    @address = address
    @stories = stories
  end
end

class Skyscraper < Building
  def initialize(name, address, stories)
    super(address, stories)
    @name = name
  end
end

van_dyke = Skyscraper.new('Van Dyke', '4280 East Iowa Ave', 12)
p van_dyke

class Settlement
  def initialize
    @population = 1
  end
end

class City < Settlement
  attr_reader :library

  def initialize
    @population = 100_000
    @library = Library.new
  end
end

class Town < Settlement
  def initialize
    @population = 10_000
  end
end

class Library
  attr_reader :books

  def initialize
    @books = 1000
  end

  def visit
    puts "I visited the library and saw #{books} books!"
  end
end

City.new.library.visit

class A
  HI = 'hi'
end

class A
  puts HI
end

class C
  def initialize
    @name = 'bob'
    @age = 100
  end

  def call_initialize
    initialize
  end
end

puts C.new.call_initialize
