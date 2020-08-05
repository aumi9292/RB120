# frozen_string_literal: true

module Walkable
  def walk
    "Let's go for a walk!"
  end
end

# 1
puts 'Hello'.class
puts 5.class
puts [1, 2, 3].class

# 2
class Cat
  include Walkable

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    "Hi, I'm #{name}, I'm a cat!"
  end
end

kitty = Cat.new('Sophie')
p kitty.greet
p kitty.name = 'Luna'
p kitty.greet
p kitty.walk
