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
    @player_ships = [@player_cruiser, @player_submarine]        # can we remove these?
    @computer_ships = [@computer_cruiser, @computer_submarine]  # can we remove these?
    @cells = @computer_board.cells.keys
  end

  def run
    puts "Welcome to BATTLESHIP"
    loop do
      main_menu
      break if game_ends || main_menu == 'q'
    end
      puts "Goodbye!"
  end

  def main_menu
    puts "Enter 'p' to play. Enter 'q' to quit."
    choice = gets.chomp.downcase
    case choice
    when 'p'
      setup_game
      play_game until game_ends?
    when 'q'
      exit
    else 
      puts "You were ordered to enter 'p' or 'q' soldier. GET TO IT!"
    end  
    choice
  end

  def play_game
    loop do
      display_boards
      player_shot
      break if game_ends?
      computer_shot
      break if game_ends?
    end

    p "Final Battlefield"
    display_boards
    puts "Whether win or lose, we are all heroes. Play again? (Yes or No)"
    choice = gets.chomp.downcase
    case choice
    when 'yes'
      run
    when 'no'
      exit
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
    puts "Enter 3 coordinates for your Cruiser.\n*** (For example: A1 A2 A3) ***"
    cruiser_coordinates = gets.chomp.upcase.split(" ").sort
    while !@player_board.valid_placement?(@player_cruiser, cruiser_coordinates)
      puts "Invalid coordinates. Please try again:"
      cruiser_coordinates = gets.chomp.upcase.split(" ").sort
    end
    @player_board.place(@player_cruiser, cruiser_coordinates)
  
    puts "Enter the coordinates for your Submarine.\n*** (For example: C3 C4) ***"
    submarine_coordinates = gets.chomp.upcase.split(" ").sort
    while !@player_board.valid_placement?(@player_submarine, submarine_coordinates)
      puts "Invalid coordinates. Please try again:"
      submarine_coordinates = gets.chomp.upcase.split(" ").sort
    end
    @player_board.place(@player_submarine, submarine_coordinates)
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render(true)
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

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
                  when "H" then "was a hit!"
                  when "M" then "was a miss"
                  when "X" then "sunk a ship!"
                  else "Something has gone wrong"
                  end
    puts "Your shot on #{shot} #{shot_result}."  
  end

# This could be a helper method for both players
  
  def computer_shot
    shot = @cells.sample
    shot = @cells.sample until !@player_board.cells[shot].fired_upon?
    @player_board.cells[shot].fire_upon
    result = @player_board.cells[shot].render
    shot_result = case result
                  when "H" then "was a hit!"
                  when "M" then "was a miss"
                  when "X" then "sunk a ship!"
                  else "Something has gone wrong"
                  end
    puts "My shot on #{shot} #{shot_result}."
  end


  #### THESE MESSAGES ARE GETTING CALLED TWICE. I CAN'T FIGURE OUT HOW TO FIX IT WITHOUT SCREWING UP
  #### THE CPU PLACING THEIR SUBMARINE.
  def game_ends?
    # @player_ships.all?(&:sunk?) || @computer_ships.all?(&:sunk?)
    if @player_ships.all?(&:sunk?)
      p "You return home in disgrace."
      return true
    elsif @computer_ships.all?(&:sunk?)
      p "You have eleminated the enemy scum. Proceed with honor."
      return true
    else 
      return false
    end
  end
end


game = Battleship.new
game.run

