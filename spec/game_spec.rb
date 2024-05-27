require 'spec_helper'

RSpec.describe Game do
  before(:each) do

  end

  # Functionality we'll need for in It.3:

  # Running game

    # DISPLAY Welcome message
    # PROMPT User to `play` or `quit` with inputs
      # REPROMPT when input invalid

#########################################################

  # Game setup
  
    # CPU Ship Placement
      # Use built-in Ruby methods to gen random coords
      # Verify with #valid_placement?
    # Player Ship Placement
      # Verify with #valid_placement?

#########################################################
        
  # The Turn
  
    # DISPLAY Both Boards
    # PROMPT Player to fire shot with instructions
      # REPROMPT Player if input invalid
        # Handle edge cases:
          # check shots with #valid_placement?
          # upcase shot inputs
        # No duplicate shots allowed
          # "Please select a coordinate that has not already been fired upon."
    # Render board responds to hits
      # "." = Not fired upon
      # "M" = Fired upon, MISS
      # "H" = Fired upon, HIT
      # "X" = Ship sunk
    # DISPLAY Both Shot Results:
      # DISPLAY both updated boards
        # "Your shot on A4 was a miss."
        # "My shot on C1 was a miss."
    # DISPLAY Ship Sunk after kill shot:
      # "Your shot on A4 sunk my cruiser/submarine."
      # "My shot on C1 sunk your cruiser/submarine."
    
#########################################################
      
    # Game Over

      # DISPLAY Game Over message after either player sinks other's ships:
      # "I won!"
      #   or
      # "You won!"

        # (Unlikely) Edge case where both are sunk at once 
        # Probably wouldn't worry about this.
        # But could talk about it in presentation to instructor
      
      # Return to Main Menu  
end