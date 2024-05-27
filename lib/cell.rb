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
    @ship.hit if @ship  # <-- Does this mean "Call the `hit` method on the `ship` attribute if `@ship` == true?"
                          # Is that how you'd word that?  Just trying to understand all of our code 100%
  end

  def fired_upon?
    @fired_upon
  end

  def render(reveal_ship = false)
    if !empty? && fired_upon? && @ship.sunk?
      "X"
      # “X” if the cell has been fired upon and its ship has been sunk.
    elsif !empty? && fired_upon
      "H"
      # “H” if the cell has been fired upon and it contains a ship (the shot was a hit).
    elsif empty? && fired_upon
      "M"
      # “M” if the cell has been fired upon and it does not contain a ship (the shot was a miss).
    elsif reveal_ship && !empty?
      "S"
      # Additionally, we will include an optional boolean argument to indicate 
      # if we want to reveal a ship in the cell even if it has not been fired upon. 
      # This should render a cell that has not been fired upon and contains a ship as an “S”. 
      # This will be useful for showing the user where they placed their ships and for debugging.
    else
      "." 
      # ”.” if the cell has not been fired upon.
    end
  end
end