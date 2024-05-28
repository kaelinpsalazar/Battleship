require_relative 'board'
require_relative 'ship'
require_relative 'cell'


class Battleship

  def initialize
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @player_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @player_ships = [@player_cruiser, @player_submarine]        # can we remove these
    @computer_ships = [@computer_cruiser, @computer_submarine]  # can we remove these
    @cells = ["A1", "A2", "A3", "A4", "B1", "B2", "B3","B4",    # can we simplify this with hash notation refer
              "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    
  end

  def run
    puts "Welcome to BATTLESHIP"
    loop do
      main_menu
      break if game_ends?
    end
      puts "Goodbye!"
  end

  def main_menu
    puts "Enter 'p' to play. Enter 'q' to quit."
    choice = gets.chomp.downcase
    case choice
    when 'p'
      setup_game

      # until @computer_board
      loop do   # Are we using `play_game` here instead?
        display_boards
        player_shot
        computer_shot
        # Need to exit shot exchange loop with #game_ends? here

      end
    when 'q'
      exit
    else 
      puts "You were ordered to enter 'p' or 'q' soldier. GET TO IT!"
    end  
  end


  def setup_game
    computer_ship_placement(@computer_cruiser, @computer_submarine)
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    place_player_ships
  end

  def computer_ship_placement(computer_cruiser, computer_submarine)
    cruiser_coordinates = generate_random_coordinates(@computer_cruiser, @computer_cruiser.length)
    submarine_coordinates = generate_random_coordinates(@computer_submarine, @computer_submarine.length)
  
    @computer_board.place(@computer_cruiser, cruiser_coordinates)
    @computer_board.place(@computer_submarine, submarine_coordinates)
  end

  def generate_random_coordinates(ship, length)
    loop do
      coordinates = @cells.sample(length)
      return coordinates if @computer_board.valid_placement?(ship, coordinates)
    end
  end


  def place_player_ships
    puts "Enter the coordinates for your Cruiser (3 cells):"
    cruiser_coordinates = gets.chomp.upcase.split
    while !@player_board.valid_placement?(@player_cruiser, cruiser_coordinates)
      puts "Invalid coordinates. Please try again:"
      cruiser_coordinates = gets.chomp.upcase.split
    end
    @player_board.place(@player_cruiser, cruiser_coordinates)
  
    puts "Enter the coordinates for your Submarine (2 cells):"
    submarine_coordinates = gets.chomp.upcase.split
    while !@player_board.valid_placement?(@player_submarine, submarine_coordinates)
      puts "Invalid coordinates. Please try again:"
      submarine_coordinates = gets.chomp.upcase.split
    end
    @player_board.place(@player_submarine, submarine_coordinates)
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end


  ### BUG ###
  # Returning `invalid coordinate` when actually a hit - FIXED

  # def player_shot
  #   puts "Enter the coordinate for your shot:"
  #   coordinate = gets.chomp.upcase
  #   # until input coords = valid board coords           &                     
  #   until @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
  #     puts "Invalid coordinate. Please enter a valid coordinate:"
  #     coordinate = gets.chomp.upcase
  #   end
  #   @computer_board.cells[coordinate].fire_upon
  #   result = @computer_board.cells[coordinate].render
  #   puts "Your shot on #{coordinate} was #{result}."
  # end


  def player_shot
    puts "Enter the coordinate for your shot:"
    shot = gets.chomp.upcase
    until @computer_board.valid_coordinate?(shot) && !@computer_board.cells[shot].fired_upon?
      puts "Invalid target coordinate! Please try again:"
      shot = gets.chomp.upcase
    end
    @computer_board.cells[shot].fire_upon
    result = @computer_board.cells[shot].render
    shot_result = case result
                  when "H" then "a hit!"
                  when "M" then "a miss"
                  when "X" then "a sunk ship!"
                  else "Something has gone wrong"
                  end
    puts "Your shot on #{shot} was #{shot_result}."  # This could be a helper method for both players
  end

  def computer_shot
    # Check if cell empty before firing
    coordinate = @cells.sample
    coordinate = @cells.sample until !@player_board.cells[coordinate].fired_upon?
    @player_board.cells[coordinate].fire_upon
    result = @player_board.cells[coordinate].render
    puts "My shot on #{coordinate} was #{result}."
  end



  def player_shot
    puts "Enter the coordinate for your shot:"
    coordinate = gets.chomp.upcase
    until @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
      puts "Invalid coordinate. Please enter a valid coordinate:"
      coordinate = gets.chomp.upcase
    end
    @computer_board.cells[coordinate].fire_upon
    result = @computer_board.cells[coordinate].render
    puts "Your shot on #{coordinate} was #{result}."
  end

  def computer_shot
    coordinate = @cells.sample
    coordinate = @cells.sample until !@player_board.cells[coordinate].fired_upon?
    @player_board.cells[coordinate].fire_upon
    result = @player_board.cells[coordinate].render
    puts "My shot on #{coordinate} was #{result}."
  end



  def game_ends?
    @player_ships.all?(&:sunk?) || @computer_ships.all?(&:sunk?)
  end
end


game = Battleship.new
game.run

# Game now render's player's shots as hits
# Game does not exit shot exchange loop after CPU ships sunk





# Make Main Menu
  # Greet User - "Welcome to Battleship"
    #         "To start a new game - enter 'P' "
    #             "To quit - enter 'Q' "
    #         
    #           "For a Dad Joke - enter 'DJ' "

    #####################################################

    # (Add asci art for Main Menu)
    ### If player enters anything besides P, Q, or DJ -> prompt to try again
    # Player returns to Main Menu after game end

# Setup
  # Computer places ships (behind the scenes)
    # Use randomization but use It.2 placement rules

# Prompt Player to place ships with instructions
  # Show empty gameboard for visual aid
    # Follow It.2 placement rules

      # DISPLAY TO TERMINAL FOR PLAYER

      # "I have laid out my ships on the grid.""
      # "You now need to lay out your two ships."

# The Cruiser is three units long and the Submarine is two units long.
#   1 2 3 4
# A . . . .
# B . . . .
# C . . . .
# D . . . .

# "To correctly place a ship on the board, 
# please enter your desired grid coordinates 
# starting with the letter first, 
# followed by the number."

# For example: A3 B3 C3

# Enter the squares for the Cruiser (3 spaces):
# >
# When the user enters a valid sequence of spaces, the ship should be placed on the board, 
# the new board with the ship should be shown to the user, and then the user should be asked to place the other ship.

# Enter the squares for the Cruiser (3 spaces):
# > A1 A2 A3

#   1 2 3 4
# A S S S .
# B . . . .
# C . . . .
# D . . . .
# Enter the squares for the Submarine (2 spaces):
# >
# If the user enters an invalid sequence, they should be prompted again:

# Enter the squares for the Submarine (2 spaces):
# > C1 C3
# Those are invalid coordinates. Please try again:
# > A1 B1
# Those are invalid coordinates. Please try again:
# > C1 D1
# The Turn
# During the main game, players take turns firing at one another by 
# selecting positions on the grid to attack.

# A single turn consists of:

# Displaying the boards
# Player choosing a coordinate to fire on
# Computer choosing a coordinate to fire on
# Reporting the result of the Player’s shot
# Reporting the result of the Computer’s shot
# Displaying the Boards
# At the start of the turn, the user is shown both boards. The user should 
# see their ships but not the computer’s ships:

# =============COMPUTER BOARD=============
#   1 2 3 4
# A M . . M
# B . . . .
# C . . . .
# D . . . .
# ==============PLAYER BOARD==============
#   1 2 3 4
# A S S S .
# B . M . .
# C M . S .
# D . . S .

# Player Shot
# The player should be asked for a coordinate to fire on. If they enter an 
# invalid coordinate, they should be prompted until they enter a valid one:

# Enter the coordinate for your shot:
# > D5
# Please enter a valid coordinate:
# > Z1
# Please enter a valid coordinate:
# > A4
# Computer Shot
# The computer should choose a random space on the board. The computer should 
# not fire on a space that has already been fired on.

# Results
# The results of the shots should be displayed:

# Your shot on A4 was a miss.
# My shot on C1 was a miss.
# The game needs to handle all of the following results:

# A shot missed
# A shot hit a ship
# A shot sunk a ship
# Coordinates that have already been fired upon
# It is possible that the user enters a coordinate they have already fired upon. 
  # You need to add something that informs the user that this is the case. 
    # You may choose to either prompt them again for a coordinate they haven’t 
      # fired on, or let them choose it again and inform them in the results phase that 
        # they selected this coordinate again.

# End Game
# The game is over when either the computer or the user sinks all of the enemy ships. 
# When this happens, the user should see a message stating who won:

# You won!
# or

# I won!
# Then, they should be returned to the Main Menu asking them if they 
# would like to play or quit.

# Functionality Checklist
# This checklist summarizes all of the functionality you are expected to build. 
# This will be used to assess the completion of your project:

# Main Menu:

# User is shown the main menu where they can play or quit
# Setup:

# Computer can place ships randomly in valid locations
# User can enter valid sequences to place both ships
# Entering invalid ship placements prompts user to enter valid placements
# Turn:

# User board is displayed showing hits, misses, sunken ships, and ships
# Computer board is displayed showing hits, misses, and sunken ships
# Computer chooses a random shot
# Computer does not fire on the same spot twice
# User can choose a valid coordinate to fire on
# Entering invalid coordinate prompts user to enter valid coordinate
# Both computer and player shots are reported as a hit, sink, or miss
# User is informed when they have already fired on a coordinate
# Board is updated after a turn
# End Game:

# Game ends when all the user’s ships are sunk
# Game ends when all the computer’s ships are sunk
# Game reports who won
# Game returns user back to the Main Menu