require 'spec_helper'

RSpec.describe Ship do
    before(:each) do
        @ship = Ship.new("Cruiser", 3)
    end

    describe "initialize" do
        it "creates a ship" do
            expect(@ship.name).to eq ('Cruiser')
            expect(@ship.length).to eq(3)
            expect(@ship.health).to eq(3)
        end
    end

    describe 'hit' do
        it 'reduces ship health by 1' do
            @ship.hit
            expect(@ship.health).to eq(2)

        end
    end


    describe "sunk?" do
        it "sinks a ship when it runs out of health" do
            3.times {@ship.hit}
            expect(@ship.sunk?).to eq(true)
        end
    end
end