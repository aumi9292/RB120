# frozen_string_literal: true

class Cat
  @@count = 0
  COLOR = 'purple'

  attr_accessor :name, :count

  def initialize(name)
    @name = name
    @@count += 1
  end

  def self.generic_greeting
    p self
    "Hello, I'm a cat"
  end

  def rename(name)
    self.name = name
  end

  def upcase_name
    @name.upcase
  end

  def identify
    p self
  end

  def personal_greeting
    "My name is #{name}! My color is #{COLOR}"
  end

  def self.total
    @@count
  end

  def to_s
    "I'm #{name}!"
  end
end

p Cat.generic_greeting
p kitty = Cat.new('Sophie')
p kitty.rename('bob')
p kitty.name
kitty.identify
p kitty.class.generic_greeting
p kitty.personal_greeting
yolo = Cat.new('ko')
p Cat.total
puts kitty
p kitty.upcase_name

# class Person
#   attr_writer :secret

#   def initialize
#     @secret = nil
#   end

#   def share_secret
#     secret
#   end

#   private

#   attr_reader :secret
# end

# jim = Person.new
# # jim.secret
# jim.secret = 'pssst'
# p jim.share_secret

class Person
  attr_writer :secret

  def compare_secret(other)
    secret == other.secret
  end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a secret!'
puts person1.compare_secret(person2)

class Cities
  def initialize(population, avg_rent, median_home_price, commute_time, unemployment_rate)
    @population_size = population
    @avg_rent = avg_rent
    @median_home_price = median_home_price
    @commute_time = commute_time
    @unemployment_rate = unemployment_rate
    @avg_salary
  end
end
