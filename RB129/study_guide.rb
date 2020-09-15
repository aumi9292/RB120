# classes and objects
# Classes are blueprints/templates/molds that dictate the methods available for and the potential attributes of objects made from that class. Objects are indidivual instances of a class that share the same methods/behaviors and have a unique state, or collection of instance variables.
class Computer
  attr_reader :year, :brand

  def initialize(year, brand)
    @year = year
    @brand = brand
  end

  def turn_on
    puts "I'm up!"
  end
end

laptop = Computer.new(2020, 'Apple')
p laptop.year
laptop.turn_on

# use attr* methods to create setter and getter methods
# attr_* methods are short-hand for creating getter and setter methods. attr_accessor creates both a getter and setter, attr_reader creates a getter method, attr_writer creates a writer method. If these are public, then their functionalities are available to be called on any instance of the class.

class Banana
  attr_accessor :size

  def initialize(size)
    @size = size
  end
end

bane = Banana.new('large')
p bane.size
bane.size = 'small'
p bane.size

# how to call getters and setters
class Coffee
  def initialize(roast, strength)
    @roast = roast
    @strength = strength
  end

  def roast
    @roast.upcase.strip
  end

  def strength=(strength)
    @strength = strength.capitalize
  end

  def strength
    @strength.split(' ')
  end

  def self.increase_strength
    strength = 100
  end
end

brew = Coffee.new('light', 'strong')
p brew.roast
p brew.strength = "super duper strong"
p brew.strength
p Coffee.increase_strength
p brew.strength

# instance methods versus class methods
# Instance methods are methods defined within a class definition that can be called on any instance/object instantiated from the class. Class methods are defined within a class definition and prefixed with self. They are available to be called only on the class directly rather than any objects made from it. Class methods cannot access instance variables

# Instance variables can be referenced directly (@i_var) or through a method that references the instance variable. I_vars should generally be referenced via getter methods rather than directly. This ensures that any formatting done to the instance variable is preserved, serves as another layer of protection (you can call dup/clone on the instance variable in the getter method), and is more readable (no code littered with @ sigils).

class City
  def initialize(name, population)
    @name = name
    @population = population
  end

  def population
    @population.divmod(1000).first * 1000
  end
end

denver = City.new('Denver', 675321)
p denver.population

# Inheritance means that one class can inherit methods and constants from another class. The subclass can either extend or override the functionality of these methods defined in the superclass. Classes can only inherit directly from one class (Ruby is a single-inheritance language). Superclasses can group methods that are repeated in multiple classes and extract them to one class, leading to dryer code and greater code re-use. Superclasses are more general than sub-classes.

class Building
  attr_accessor :type, :age, :last_renovated

  def initialize(type, age)
    @type = type
    @age = age
  end

  def renovate
    puts "Last renovated: #{self.last_renovated = Time.now.year}"
  end
end

class Condo < Building
  attr_reader :floor

  def initialize(type, age, floor)
    super(type, age)
    @floor = floor
  end

  def overlook_city
    puts "Ahh, that's a nice view!"
  end

  private

  attr_writer :floor
end

apt = Condo.new('apartment', 10, 55)
apt.overlook_city
apt.renovate
# apt.floor = 100
p apt.floor

# Encapsulation is grouping data and allowing interaction with that data in particular ways through public instance methods. Encapsulation is a form of data protection--exposing only the information you intend to and only allowing people to interact with that data in the ways you dictate.

# Polymorphism in Ruby means that methods of the same name can have different implementations when they're defined differently in different classes. In other words, objects instantiated from different classes can respond to the same method name and different behaviors will follow.

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

module Timeable
  attr_reader :time_created

  def initialize
    @time_created = Time.now
  end

  def age_in_seconds
    Time.now - time_created
  end
end

class Idea
  include Timeable

  def initialize(thought)
    @thought = thought
    super()
  end
end

fleeting_thought = Idea.new("Coffee?")
p fleeting_thought.time_created
p fleeting_thought.age_in_seconds

class Book
  def initialize(title, author, pages)
    @title = title
    @author = author
    @pages = pages
  end

  attr_reader :title

  attr_reader :author

  attr_reader :pages

  def pages=(new_pages)
    new_pages.instance_of?(Integer) ? @pages = new_pages : puts('Sorry, please enter a number')
  end

  def to_s
    "#{title}\nBy #{author}"
  end

  def read; end
end

class Novella < Book
  def binge_read
    puts "I read it all in one night!"
  end
end

class Dictionary < Book
  def learn_new_word
    puts ['tenable', 'crepuscular', 'petrichor'].sample
  end

  def binge_read
    puts "Zzzzzzzz"
  end
end

sad_story = Novella.new('Flowers for Algernon', 'Daniel Keyes', 23)
websters = Dictionary.new('1978 Edition', 'Webster Team', 14_542)
[sad_story, websters].each(&:binge_read)

# p triumph_of_the_city = Book.new('Triumph of the City', 'David Glaeser', 338)
# p walkable_city = Book.new('Walkable City Rules', 'Jeff Speck', 290)
# walkable_city.pages = 'hello'
# puts walkable_city
# p walkable_city

# lexical scope: items are grouped together based on where they appear in code, not on an abstract object model
WHEELS = 1000
module Veh
  WINDOWS = 4
end

class Car
  include Veh
  WHEELS = 50
  a = 4
end

class Boat
  p(WHEELS)
  # p a
end

p Car::WHEELS

# A constant defined in the class is available if the class is opened again at a later point. A local variable initialized in the class is not avaialable later on if the class is opened up. You will get an undefined local var or method error
