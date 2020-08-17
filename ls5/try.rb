class Greet
end

class Hi < Greet
  @@say = 'hi'

  def self.say
    @@say
  end
end

class Bye < Greet
  @@say = 'bye'

  def self.say
    @@say
  end
end

p Bye.say
p Hi.say
p Hi.say
p Bye.say
