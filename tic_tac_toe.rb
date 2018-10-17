
#######################################################################################################
class Board
		attr_accessor :board
	def initialize
		@board = {"A1" => " ", "A2" => " ", "A3"=> " ", "B1"=> " ", "B2"=> " ", "B3"=> " ", "C1"=> " ", "C2"=> " ", "C3"=> " "}
		#display_board(@board)
	end

	def display_board(board=@board)
		puts <<~BOARD


				 .	  	        A      B      C
				 		       _________________  
						   1  |  #{@board["A1"]}  |  #{@board["B1"]}  |  #{@board["C1"]}  |
						      |-----|-----|-----|	
						   2  |  #{@board["A2"]}  |  #{@board["B2"]}  |  #{@board["C2"]}  |
						      |-----|-----|-----|
						   3  |  #{@board["A3"]}  |  #{@board["B3"]}  |  #{@board["C3"]}  |
				 		       -----------------
		BOARD
	end

	def add_value_to_board(value_board, player)
		if @board[value_board] != " "
			puts "Oops, cette case est soit occupée soit elle n'existe pas ! Réessaye !"
			value_board = gets.chomp.to_s
		else
			@board[value_board] = player.symbol
		end
	end

	def victory_condition(symbol)
		(@board["A1"] == "#{symbol}" && @board["A2"]  == "#{symbol}" && @board["A3"] == "#{symbol}") ||
      (@board["B1"] == "#{symbol}" && @board["B2"]  == "#{symbol}" && @board["B3"] == "#{symbol}") ||
      (@board["C1"] == "#{symbol}" && @board["C2"]  == "#{symbol}" && @board["C3"] == "#{symbol}") ||
      (@board["A1"] == "#{symbol}" && @board["B1"]  == "#{symbol}" && @board["C1"] == "#{symbol}") ||
      (@board["A2"] == "#{symbol}" && @board["B2"]  == "#{symbol}" && @board["C2"] == "#{symbol}") ||
      (@board["A1"] == "#{symbol}" && @board["B2"]  == "#{symbol}" && @board["C3"] == "#{symbol}") ||
      (@board["A3"] == "#{symbol}" && @board["B2"]  == "#{symbol}" && @board["C1"] == "#{symbol}")
	end

end
####################################################################################################
#Class pour creer un joueur
class Player
		attr_accessor :name, :symbol
	def initialize(name_, symbol)
		@name = name_
		@symbol = symbol
	end

	def is_the_winner
		puts "#{@name} is the winner !"
	end
end

class Game
	#Creation du jeu, Creation des 2 personnages
		attr_accessor :first_player, :second_player, :symbol1, :symbol2
	def initialize(first_name,symbol1, second_name, symbol2)
		@first_player = Player.new(first_name,symbol1)
		@second_player = Player.new(second_name,symbol2)
		@table = Board.new
		turn
	end

	def turn
		100.times do 
			world = World.new
			puts "\n\n 	#{@first_player.name.upcase} SELECTIONNE LA CASE OÚ POSER TON PION > (#{@first_player.symbol}) :\n"
			@table.display_board
			value_board = gets.chomp.to_s
			world.clear_the_screen
			@table.add_value_to_board(value_board,@first_player)
			if @table.victory_condition(@first_player.symbol) == true
				@first_player.is_the_winner
				break
			end
			world.clear_the_screen
			puts "\n\n 	#{second_player.name.upcase} SELECTIONNE LA CASE OÙ POSER TON PION > (#{@second_player.symbol}) : \n"
			@table.display_board
			value_board = gets.chomp.to_s
			@table.add_value_to_board(value_board,@second_player)
			if @table.victory_condition(@second_player.symbol) == true
				@second_player.is_the_winner
			break
			end
		world.clear_the_screen
	end
		#Display final Board per turn
		#Check if game is end && who won(Board.who_is_the_winner)
	end
###################################################################################################
class World
#Commencer le jeu, demande des pseudos des joueurs
	def start_the_game
		puts "\n\n    			NOM DU JOUEUR 1 :\n"
		joueur1 = gets.chomp.to_s
		symbol1 = which_symbol?
		symbol2 = other_symbol(symbol1)
		clear_the_screen
		puts "\n\n    			NOM DU JOUEUR 2\n\n"
		joueur2 = gets.chomp.to_s
		Game.new(joueur1, symbol1, joueur2, symbol2)
	end
##### Choix du symbole
	def which_symbol?
		#clear_the_screen
		puts "\n\n    			   X ou O ?\n\n"
		symbol = gets.chomp.to_s
		#clear_the_screen
		if symbol != "X" && symbol != "O"
			clear_the_screen
			puts "\n\n 	    Oops ! Mauvais symbole, recommence !\n"
			which_symbol?
		else
			symbol
		end
	end

	def other_symbol(symbol)
		case symbol
		when "X"
			puts "Le joueur 2 aura alors les O !"
			"O"
		end
	end
########## Affichage des regles du jeu
	def rules
		f = File.read("./rules.txt")
		puts "#{f}"
		back_option = gets.chomp.to_i
		rules_option(back_option)
	end

######### Choisir les options du petit menu des regles du jeu 1) BACK 2) QUITTER LE JEU 

	def rules_option(back_option)
		if back_option == 1
			world = World.new
			world.menu
		elsif back_option == 2
			return puts "À bientot !"
		else
			puts "Oops ! Choisissez entre l'option 1 ou 2 !"
			back_option = gets.chomp.to_i
			rules_option(back_option)
		end
	end

	def end_the_game
		return 0
	end
	def clear_the_screen
		clear_code = %x{clear}
		print clear_code
	end
############################################################
##-----------------------START GAME-----------------------##
#Affichage du Menu principal du jeu
def menu
clear_the_screen
f = File.read("troll.txt")
puts "#{f}"
enter = gets.chomp.to_i
clear_the_screen
puts "   --------------------------------------------------------"
puts "   |                 | TIC-TAC-TOE GAME |                 |"
puts "   --------------------------------------------------------\n\n"
puts "		BIENVENUE SUR TIC-TAC-TOE GAME\n\n"
puts "		   (1) START THE GAME (1)"
puts "		   (2) REGLES DU JEU  (2)"
puts "		   (3)     QUITTER    (3)"

#Choisir les options du menu principal 1) START 2) REGLES DU JEU 3) QUITTER LE JEU
option = gets.chomp.to_i
	clear_the_screen
	world = World.new
	if option == 1
			world.start_the_game
		elsif option == 2
			world.rules
		else
			puts "À bientot !"
			world.end_the_game
		end
	end
	world = World.new
	world.menu
end
end

