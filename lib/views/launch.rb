class Launch

  attr_accessor :players, :nbr_of_game, :current_game

  def welcome_message
    puts "-------------"
    puts "-- WELCOME --"
    puts "-------------"
  end

  def ask_player_name(i)
    puts "Quel est le nom du joueur #{i} ?"
    print ">> "
    gets.chomp  
  end

  # initialize lance les bases d'une partie : 2 joueur - welcome message - regles
  def initialize
    self.welcome_message

    @nbr_of_game = 0
    @players = []
    for i in 1..2 do
      players << Player.new(ask_player_name(i), i)
    end
    @players.each {|player| player.show_player}

    self.launch_game
    #self.show_board_rules
  end

# ----- DEF QUI LANCE LE JEU UNE FOIS LES PLAYERS DEFINIE ------------
# ----- cree un Game.new qui a son tour créer Board.new > Boarcase.new


  def launch_game
    @nbr_of_game += 1
    @current_game = Game.new(players)
    puts "\n\nLet's go !!! - partie #{nbr_of_game} entre #{players[0].name.capitalize} et #{players[1].name.capitalize}"
    sleep 1

    #current_game.board.is_full? == false || 
    
    until @current_game.board.is_winner? == true do
      self.who_is_playing #=> affiche a qui de joueur
      self.player_choice #=> choix du joeur et traitement de l'info
      self.show_board #=> affiche le board
      #break if current_game.board.is_full? == false || @current_game.board.is_winner? == false
      self.change_run #=> ajout un tour a @run
      #binding.pry
    end
    puts "partie fini"
  end

# --------------------------------------------------------------------

  def show_board
    ShowGame.new.show_board_game(current_game)
  end

  def show_board_rules
    ShowGame.new.show_board_rules
  end

  # affiche a quel joueur c'est de jouer
  #calculer en fonction du % de @run selon al position de chaque joueur (1 ou 2)

  def who_is_playing
    if current_game.run % 2 == 1
      #system('clear')
      puts "\n#{players[0].name.capitalize} c'est à toi, dans quelle case joues-tu ?"
    else
      #system('clear')
      puts "\n#{players[1].name.capitalize} c'est à toi, dans quelle case joues-tu ?"
    end
  end

  # Recupere la case choisi par le joueur - verif que la valeur est bonne - si non invit a recommencer
  # si oui appel method de verif + changement de valeur de la case correspond au choix du joueur

  def player_choice
    print ">> "
    choice = gets.chomp.to_i

    possibilities = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    case choice
    when *possibilities 

      if current_game.boardcase_is_empty?(translate_player_choice(choice)) == true
        current_game.change_boardcase(translate_player_choice(choice))
      else
        puts "la case choisie est déjà occupée, choisie en une autre"
        self.player_choice
      end
    else
      puts "La commande entrée ne correspond a aucune case du board, essaie encore"
      self.player_choice
    end
  end
  
  # converti le choix du player - entier de 1 à 12 - en array correspondant à la bonne case du board

  def translate_player_choice(choice)
    return choice_array = [0, 0] if choice == 1
    return choice_array = [0, 1] if choice == 2
    return choice_array = [0, 2] if choice == 3
    return choice_array = [1, 0] if choice == 4
    return choice_array = [1, 1] if choice == 5
    return choice_array = [1, 2] if choice == 6
    return choice_array = [2, 0] if choice == 7
    return choice_array = [2, 1] if choice == 8
    return choice_array = [2, 2] if choice == 9
  end

  # change le numéro du tour du game - @run permet de determineer quel joueur joue
  
  def change_run
    current_game.run += 1 
  end

end