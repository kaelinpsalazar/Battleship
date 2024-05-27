require_relative 'board'
require_relative 'ship'
require_relative 'cell'


class Battleship

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_ships = []
    @computer_ships = []
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
    puts "Enter 'p to play. Enter 'q' to quit."
    choice = gets.chomp.downcase
    case choice
    when 'p'
      setup_game
      play_game
    when 'q'
      exit
    else 
      puts "You were ordered to enter 'p' or 'q' soldier. GET TO IT!"
    end  
  end


  def setup_game
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @computer_ships = computer_ship_placement(cruiser, submarine)
    p "I have laid out my ships on the grid."
    p "You now need to lay out your two ships."
    p "The Cruiser is three units long and the Submarine is two units long."
    place_player_ships
  end

  def computer_ship_placement(cruiser, submarine)
    cruiser_coordinates = generate_random_coordinates(cruiser.length)
    submarine_coordinates = generate_random_coordinates(submarine.length)

    @computer_board.place(cruiser, cruiser_coordinates)
    @computer_board.place(submarine, submarine_coordinates)

  end

  def generate_random_coordinates

  end

  def place_player_ships
  
  end

  def play_game

  end

  # def player_turn

  # end

  # def computer_turn

  # end

  def game_ends?

    player_ships_sunk? || computer_ships_sunk?

  end
end


game = Battleship.new
game.run