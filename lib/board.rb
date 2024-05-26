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

    def valid_coordinate?(coordinate)
      @cells.has_key?(coordinate)
    end

    def valid_placement?(ship, placement)
      # require 'pry'; binding.pry
      if !placement.all? {|coordinate| valid_coordinate?(coordinate)} || !consecutive_coordinates?(placement) || ship.length != placement.length
      false
      else
      true
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

    
end