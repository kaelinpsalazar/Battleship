class Ship

  attr_reader :name,
              :length,
              :health

  def initialize (name, length)
    @name = name
    @length = length
    @health = length
  end

  def hit
    @health -= 1
  end

  def sunk?
    @health <= 0  # Does this need to be `<= 0` or should it just be `== 0` because I don't think we should be able
                    # to lower the ship health below 0, correct?  Once the ship is sunk, it won't be able to receive
                    # more hits, right?
  end
end