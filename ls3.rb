class Person
  attr_accessor :name

  def ==(other)
    name == other.name
  end
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

p bob == bob2 # => false

bob_copy = bob
p bob == bob_copy

p Person.new.equal? Person.new

# fake operators
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person)
    age > other_person.age
  end
end

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end

  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
  end
end

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)

niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)
niners << Person.new("Deion Sanders", 47)

dream_team = cowboys + niners
dream_team.name = "Dream Team"

dream_team[4]
dream_team[5] = Person.new("JJ", 72)

puts dream_team.inspect

# exceptions

begin
  'hello' / 0
  1 / 0
  1 + 'hello'
rescue TypeError
  puts 1 + 'hello'.to_i
  puts 'WRONG WRONG ERROR ERROR'
rescue ZeroDivisionError
  puts "Sorry that's 0"
rescue NoMethodError
  puts "Strings cannot be divided"
end

begin
  5[0] = 10
rescue NoMethodError => e
  puts e.class
  puts e
end

name = 'bob' if false

p name

str1 = "I'm a string"
str2 = str1

p str2.eql?(str1)

str1 = "I am a string"
str2 = "I am a string"

p str1 === str2
p (str1 <=> str2) == 0
p str1.equal?(str2)

class Shape
  @@sides = nil

  def self.sides
    @@sides
  end

  def sides
    @@sides
  end
end

class Triangle < Shape
  def initialize
    @@sides = 3
  end
end

class Quadrilateral < Shape
  def initialize
    @@sides = 4
  end
end

p Triangle.new.sides
p Triangle.new.sides
p Triangle.new.sides
p Triangle.new.sides
p Triangle.new.sides
p Triangle.new.sides
p Triangle.new.sides
p Triangle.sides
p Triangle.sides
p Triangle.sides
p Triangle.sides
p Triangle.sides
p Triangle.sides
p Triangle.sides
p Triangle.sides
p Quadrilateral.new.sides
p Quadrilateral.new.sides
p Quadrilateral.new.sides
p Triangle.sides
p Triangle.new.sides
p Triangle.new.sides
p Triangle.sides

module Describable
  def describe_shape
    "I am a #{self.class} and have #{self.class::SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides # => 4
p Square.new.sides # => 4
p Square.new.describe_shape # => "I am a Square and have 4 sides."
