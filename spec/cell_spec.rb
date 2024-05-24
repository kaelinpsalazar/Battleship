require 'spec_helper'

RSpec.describe Cell do
    before(:each) do
        @cell = Cell.new("B4")
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
end