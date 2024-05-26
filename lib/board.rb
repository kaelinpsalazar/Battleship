class Board
  attr_reader :cells
    
    def initialize
      @cells = {
        "A1" => Cell.new("A1"),
        "A2" => Cell.new("A2"),
        "A3" => Cell.new("A3"),
        "A4" => Cell.new("A4"),
        "B1" => Cell.new("B1"),
        "B2" => Cell.new("B2"),
        "B3" => Cell.new("B3"),
        "B4" => Cell.new("B4"),
        "C1" => Cell.new("C1"),
        "C2" => Cell.new("C2"),
        "C3" => Cell.new("C3"),
        "C4" => Cell.new("C4"),
        "D1" => Cell.new("D1"),
        "D2" => Cell.new("D2"),
        "D3" => Cell.new("D3"),
        "D4" => Cell.new("D4")
      }
    end

    def valid_coordinate?(coordinate) # Cannot be valid placement unless empty
      @cells.has_key?(coordinate) && @cells[coordinate].empty?
    end

    def valid_placement?(ship, placement)
      # This says: "If any coords passed in `placement` aren't valid  OR          are NOT consecutive         OR do not match ship length..."
      if !placement.all? {|coordinate| valid_coordinate?(coordinate)} || !consecutive_coordinates?(placement) || ship.length != placement.length
      # --> return false
      false
      # Otherwise:
      else
        # --> return true 
        true
        # (meaning: the coordinates were valid)
      end
    end
    
    def consecutive_coordinates?(placement)
      row = placement.map{|cell| cell[0]}
      col = placement.map{|cell| cell[1]}
      
      if col.uniq.length == 1
        consecutive_row = row.each_cons(2).all? { |a, b| b == a.next }
      elsif row.uniq.length == 1
        consecutive_col = col.each_cons(2).all? { |a, b| b == a.next }
      else
        false
      end
    end

    # This enumerable iterates over arrays passed in via `cells`
    # It places the ship object passed through `ship` into the cell objects stored
      # in the instance of `board`
    def place(ship, cells)
      cells.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end

    # Board does not reveal User's ships by default - must be passed as argument to override
    def render(reveal = false)
      if reveal == true
        "  1 2 3 4 \n" \
        "A #{@cells["A1"].render(reveal)} #{@cells["A2"].render(reveal)} #{@cells["A3"].render(reveal)} #{@cells["A4"].render(reveal)} \n" \
        "B #{@cells["B1"].render(reveal)} #{@cells["B2"].render(reveal)} #{@cells["B3"].render(reveal)} #{@cells["B4"].render(reveal)} \n" \
        "C #{@cells["C1"].render(reveal)} #{@cells["C2"].render(reveal)} #{@cells["C3"].render(reveal)} #{@cells["C4"].render(reveal)} \n" \
        "D #{@cells["D1"].render(reveal)} #{@cells["D2"].render(reveal)} #{@cells["D3"].render(reveal)} #{@cells["D4"].render(reveal)} \n" 
      
      else
      "  1 2 3 4 \n" \
      "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render} \n" \
      "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render} \n" \
      "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render} \n" \
      "D #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render} \n" 
      end
    end
end