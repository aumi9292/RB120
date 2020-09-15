class A
  x = 2
end

class B
  def self.name
    @@bob
  end

  @@bob = 0
end

p B.name
