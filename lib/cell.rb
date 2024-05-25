class Cell


    attr_reader :coordinate, :ship, :fired_upon

    def initialize (coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
       
       
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


    def render
        if !fired_upon?
            "."
            # ”.” if the cell has not been fired upon.

        # elsif !fire_upon? && !empty?
        #     "S"

        elsif empty?
            "M"
          # “M” if the cell has been fired upon and it does not contain a ship (the shot was a miss).
        elsif @ship.sunk?
            "X"
            # “X” if the cell has been fired upon and its ship has been sunk.
        
            # # Additionally, we will include an optional boolean argument to indicate if we want to reveal a ship in the cell even if it has not been fired upon. This should render a cell that has not been fired upon and contains a ship as an “S”. This will be useful for showing the user where they placed their ships and for debugging.
        else
            "H"
            # “H” if the cell has been fired upon and it contains a ship (the shot was a hit).
        end

    end







end