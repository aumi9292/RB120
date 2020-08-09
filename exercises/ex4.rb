# frozen_string_literal: true

# # frozen_string_literal: true

# # # frozen_string_literal: true

# # # class Person
# # #   attr_accessor :name
# # # end

# # # person1 = Person.new
# # # person1.name = 'Jessica'
# # # puts person1.name

# # # class Person
# # #   attr_accessor :name
# # #   attr_writer :phone_number
# # # end

# # # person1 = Person.new
# # # person1.name = 'Jessica'
# # # person1.phone_number = '0123456789'
# # # puts person1.name

# # # class Person
# # #   attr_reader :phone_number

# # #   def initialize(number)
# # #     @phone_number = number
# # #   end
# # # end

# # # person1 = Person.new(1_234_567_899)
# # # puts person1.phone_number

# # # person1.phone_number = 9_987_654_321
# # # puts person1.phone_number

# # # comparing names
# # # class Person
# # #   attr_writer :last_name
# # #   attr_accessor :first_name
# # #   def first_equals_last?
# # #     first_name == last_name
# # #   end

# # #   private

# # #   attr_reader :last_name
# # # end

# # # person1 = Person.new
# # # person1.first_name = 'Dave'
# # # person1.last_name = 'Smith'
# # # puts person1.first_equals_last?

# # # who is older
# # class Person
# #   attr_writer :age
# #   def older_than?(other)
# #     age > other.age
# #   end

# #   protected

# #   attr_reader :age
# # end

# # person1 = Person.new
# # person1.age = 17

# # person2 = Person.new
# # person2.age = 26

# # puts person1.older_than?(person2)

# # class Person
# #   attr_reader :name

# #   def name=(name)
# #     @name = name.capitalize
# #   end
# # end

# # person1 = Person.new
# # person1.name = 'eLiZaBeTh'
# # puts person1.name

# # class Person
# #   attr_reader :name
# #   def name=(name)
# #     @name = "Mr. #{name}"
# #   end
# # end

# # person1 = Person.new
# # person1.name = 'James'
# # puts person1.name

# # class Person
# #   def name
# #     @name.dup
# #   end

# #   def initialize(name)
# #     @name = name
# #   end
# # end

# # person1 = Person.new('James')
# # person1.name.reverse!
# # puts person1.name

# # class Person
# #   # def initialize
# #   #   @age = nil
# #   # end

# #   def age
# #     @age * 2
# #   end

# #   def age=(age)
# #     @age = age * 2
# #   end
# # end

# # person1 = Person.new
# # person1.age = 20
# # puts person1.age

# class Person
#   attr_reader :first, :second

#   def name=(name)
#     @first, @second = name.split
#   end

#   def name
#     "#{first} #{second}"
#   end
# end

# person1 = Person.new
# person1.name = 'John Doe'
# puts person1.name

# take 2
# class Person
#   attr_accessor :name
# end

# person1 = Person.new
# person1.name = 'Jessica'
# puts person1.name

# 2

# class Person
#   attr_accessor :name
#   attr_writer :phone_number
# end

# person1 = Person.new
# person1.name = 'Jessica'
# person1.phone_number = '0123456789'
# puts person1.name

# 3
# class Person
#   attr_reader :phone_number

#   def initialize(number)
#     @phone_number = number
#   end

#   # private
#   # attr_writer :phone_number
# end

# person1 = Person.new(1_234_567_899)
# puts person1.phone_number

# person1.phone_number = 9_987_654_321
# puts person1.phone_number

# 4
# class Person
#   attr_writer :first_name, :last_name
#   attr_reader :first_name

#   def first_equals_last?
#     first_name == last_name
#   end

#   protected

#   attr_reader :last_name
# end

# person1 = Person.new
# person1.first_name = 'Dave'
# person1.last_name = 'Smith'
# puts person1.first_equals_last?

# # 5
# class Person
#   attr_writer :age
#   def older_than?(other)
#     age > other.age
#   end

#   protected

#   attr_reader :age
# end

# person1 = Person.new
# person1.age = 17

# person2 = Person.new
# person2.age = 26

# puts person1.older_than?(person2)

# 6
# class Person
#   attr_reader :name
#   def name=(name)
#     @name = name.capitalize
#   end
# end

# person1 = Person.new
# person1.name = 'eLiZaBeTh'
# puts person1.name

# 7
# class Person
#   attr_writer :name

#   def name
#     "Mr. #{@name}"
#   end
# end

# person1 = Person.new
# person1.name = 'James'
# puts person1.name

# 8
# class Person
#   def name
#     @name.dup
#   end

#   def initialize(name)
#     @name = name
#   end
# end

# person1 = Person.new('James')
# person1.name.reverse!
# puts person1.name

# 9
class Person
  def age
    @age * 2
  end

  def age=(age)
    @age = age * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age

# unexpected change
class Person
  def name=(name)
    @first, @last = name.split
  end

  def name
    "#{@first} #{@last}"
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name

class Decision
  attr_accessor :input

  def initialize
    @input = gets.chomp
  end
end

he = Decision.new
