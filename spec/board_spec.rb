require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end
  
  describe "initialize" do
    it "has cells" do
      expect(@board.cells).to be_a(Hash)
      expect(@board.cells.length).to eq(16)
    end
  end

  describe "valid_coordinate?" do
    it "validates coordinate selection" do
      expect(@board.valid_coordinate?("A1")).to eq(true)
      expect(@board.valid_coordinate?("D4")).to eq(true)
      expect(@board.valid_coordinate?("A5")).to eq(false)
      expect(@board.valid_coordinate?("E1")).to eq(false)
      expect(@board.valid_coordinate?("A22")).to eq(false)
    end
  end

  describe "validate_placement" do
    it "validates ship placement on board" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)       
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
  
      ### COORDINATES CANNOT BE DIAGONAL (MUST BE EITHER HORIZONTAL OR VERTICAL)
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
    
      # If all the previous checks pass then the placement should be valid:
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
    end
  end

  describe "place" do
    it "can place a ship" do
      @board.place(@cruiser, ["A1", "A2", "A3"])

      @cell_1 = @board.cells["A1"]
      @cell_2 = @board.cells["A2"]
      @cell_3 = @board.cells["A3"] 

      expect(@cell_1.ship).to eq(@cruiser)
      expect(@cell_2.ship).to eq(@cruiser)
      expect(@cell_3.ship).to eq(@cruiser)
      
      # Shows the same ship object occupying more than one cell simultaneously
      expect(@cell_3.ship == @cell_2.ship).to eq(true)
    end
  end

  describe "overlapping ships" do
    it "prevents two ships placed from occupying the same cell" do
      @board.place(@cruiser, ["A1", "A2", "A3"])

      expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq(false)
    end
  end

  describe "rendering gameboard" do
    it "can render the board successfully" do
      @board.place(@cruiser, ["A1", "A2", "A3"]) 

      # Shows blank gameboard
      expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      # Shows User's ships only - not Computer
      expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    
      # Will revisit to add more tests as more functionality is added
    end
  end
end