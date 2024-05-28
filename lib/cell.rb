class Cell


  attr_reader :ship, 
              :fired_upon,
              :coordinate

  def initialize (coordinate)
    @ship = nil
    @fired_upon = false
    @coordinate = coordinate
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @fired_upon = true
    @ship.hit if @ship
  end

  def fired_upon?
    @fired_upon
  end

  def render(reveal_ship = false)
    if !empty? && fired_upon? && @ship.sunk?
      "X"
    elsif !empty? && fired_upon
      "H"
    elsif empty? && fired_upon
      "M"
    elsif reveal_ship && !empty?
      "S"
    else
      "." 
    end
  end
end