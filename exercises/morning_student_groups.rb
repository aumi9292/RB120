# frozen_string_literal: true

# 8.4.20

# class Student
#   attr_accessor :name, :grade

#   def initialize(name)
#     @name = name
#     @grade = nil
#   end

#   def change_grade(new_grade)
#     self.grade = new_grade
#   end
# end

# p priya = Student.new('Priya')
# p priya.change_grade('A')
# p priya.grade # => "A"

####
class Student
  def initialize(name)
    @name = name
    @grade = nil
  end

  def change_grade(new_grade)
    self.grade = new_grade
  end

  def get_grade
    grade
  end

  private

  attr_accessor :name, :grade
end

john = Student.new('jon')
john.change_grade('b')
p john.get_grade

# Create the class structures for a minesweeper game
# (inheritance, mixins, collaboration, none)
# (is_a vs. has_a( mixins and collab), none)
# Click a square, you get a number. That number is the number of how many mines are surrounding it. If you find the mine, you can open "unopened" squares around it, opening more areas. Note when I say unopend, I mean unclicked, and when I say open, I mean clicked.
#

# problem: create a game
# game workflow
# player sees empty board
# player clicks an empty square (can only click an empty square)
# square is
# a bomb: player loses
# not a bomb: square is
# 1. safe, empty
# 2. safe, with a numeric digit representing the number of adjacent bombs--1, 2, 3, or 4
# repeat player click until
# clicks a bomb, player loses or
# all squares a player believes are safe are pressed, player 'submits' board
# if any safe are unclicked, player loses
# if all safe are clicked, player wins

# data structures
# board (8x8 grid of 64 squares) (array of arrays [[r1c1, r1c2, r1c3 ,,,], [r2c1, r2c3,,,], [r3c1, r3c3,,,,],,,,])

# square
# attributes
# unclicked, clicked
# bomb/non-bomb
# keeping track of all adjacent squares, knowledge of all 4 adjacent squares' bomb-status
# methods
# click
# flag as safe

# Collaborator object -
# object that is assigned to the state of another object.

# class Board
#   def squares=(squares)
#     @squares = [[], [], []] #simplified 3x3 grid
#   end
# end
#
# class Square
#   def initialize
#     @bomb = [true, false].sample
#     @bomb_count =
#   end
# end
#
# module Explodable
#   def explode; end
#   def show_nearby_count; end
# end
# =
# city oo design

module Buildable
  def build(hsh, building_name, address)
    hsh[building_name.intern] = address
  end

  def pave_street(arr, *street_names)
    street_names.each { |street| arr << street }
  end
end

class Settlement
  include Buildable

  attr_accessor :name, :population, :streets, :buildings
  attr_reader :elevation

  def initialize(name, population, elevation)
    @name = name
    @population = population
    @elevation = elevation
    @streets = []
    @buildings = {}
  end

  def grow_population
    self.population += 1000
  end

  def to_s
    "Name: #{name}, Population: #{population}"
  end
end

class City < Settlement
  attr_accessor :neighborhoods

  def initialize(name, population, elevation)
    super
    @neighborhoods = []
  end
end

# class Village < Settlement
# end

class Neighborhood
  attr_accessor :name, :community_centers, :parks

  def initialize(name)
    @name = name
  end

  def to_s
    "#{name.capitalize} neighborhood--Parks: #{parks}, Community centers: #{community_centers}"
  end
end

colorado_territory = Settlement.new('Colorado Territory', 5000, 5280)
p colorado_territory.grow_population
p colorado_territory.to_s
denver = City.new('Denver', 10_000_000, 5280)
p denver.to_s
denver.build(denver.buildings, 'Wentworth', '1144 15th St')
p denver.buildings
denver.build(denver.buildings, 'Cash Register Building', '1800 Broadway')
p denver.buildings
denver.pave_street(denver.streets, 'Colfax Avenue', 'Montview Blvd', 'Colorado Blvd')
p denver.streets
hale = Neighborhood.new('hale')
hale.community_centers = '9th and CO'
hale.parks = []
hale.parks << 'City Park' << 'Lindsley Park' << 'Hale Park' << 'Mayfair Park' << 'Cheesman Park'
p hale.to_s
denver.neighborhoods = hale
p denver.neighborhoods
