require 'spec_helper'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
  end


  describe 'initialize' do 
    it "creates a cell with a coordinate" do
      expect(@cell.coordinate).to eq("B4")
      expect(@cell.ship).to eq(nil)
      expect(@cell.fired_upon?).to be false
    end
  end

  describe 'empty?' do
    it 'returns true if it is empty' do
      expect(@cell.empty?).to eq(true)
    end

    it 'returns false if it is full' do
      @cell.place_ship(@cruiser)
      expect(@cell.empty?).to eq(false)
    end
  end

  describe 'place_ship' do
    it 'places ship in a cell' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)
    end
  end

  describe 'fired_upon' do
    it "hits ship if it is there" do
      expect(@cell.fired_upon?).to eq(false)
    end
  end

  describe 'render' do
    it 'populates cell' do
      @cell_1.fire_upon

      expect(@cell_1.render).to eq("M")

      @cell_2.place_ship(@cruiser)
      
      expect(@cell_2.render).to eq(".")
      expect(@cell_2.render(true)).to eq("S")
      
      @cell_2.fire_upon
      
      expect(@cell_2.render).to eq("H")
      expect(@cruiser.sunk?).to eq(false)
      
      @cruiser.hit
      @cruiser.hit

      expect(@cruiser.sunk?).to eq(true)
      expect(@cell_2.render).to eq("X")
    end
  end
end




#Finally, a Cell will have a method called render which returns a String representation of the Cell for when we need to print the board. A cell can potentially be rendered as:

# ”.” if the cell has not been fired upon.
# “M” if the cell has been fired upon and it does not contain a ship (the shot was a miss).
# “H” if the cell has been fired upon and it contains a ship (the shot was a hit).
# “X” if the cell has been fired upon and its ship has been sunk.
# Additionally, we will include an optional boolean argument to indicate if we want to reveal a ship in the cell even if it has not been fired upon. This should render a cell that has not been fired upon and contains a ship as an “S”. This will be useful for showing the user where they placed their ships and for debugging.