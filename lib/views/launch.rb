class Launch

  attr_accessor :players, :nbr_of_game, :current_game, :avatar_choice, :current_game_show

  def ask_player_name(i)
    puts "\nQuel est le nom du joueur #{i} ?"
    print ">> "
    gets.chomp
  end

  def player_avatar(i)

    puts ""
    puts "choisi ton avatar, entre 1 et #{avatar_choice.length} : #{avatar_choice}"
    print ">> "
    avatar_number = gets.chomp.to_i
    avatar = avatar_choice[avatar_number - 1]
    avatar_choice.delete_at(avatar_number - 1)
    return avatar
  end

  # initialize lance les bases d'une partie : 2 joueur - welcome message - regles
  def initialize
    @avatar_choice = ["\u{1F60E}", "\u{1F921}", "\u{1F47B}", "\u{1F47D}", "\u{1F916}" ]
    @current_game_show = ShowGame.new
    @current_game_show.welcome_message
    @nbr_of_game = 0
    @players = []
    
    for i in 1..2 do
      players << Player.new(ask_player_name(i), i, player_avatar(i))
      system('clear')
    end
    @current_game_show.show_board_rules
    @players.each {|player| player.show_player}

    puts ""
    puts "Quand tu es prêt appuie sur n'importe quelle touche \u{1F21A} pour commencer \u{25B6}"
    gets.chomp

    self.launch_game

  end

# ----- DEF QUI LANCE LE JEU UNE FOIS LES PLAYERS DEFINIE ------------
# ----- cree un Game.new qui a son tour créer Board.new > Boarcase.new


  def launch_game
    @nbr_of_game += 1
    @current_game = Game.new(players)
    system('clear')
    puts "\n\nLet's go !!! - partie #{nbr_of_game} entre #{players[0].name.capitalize} aka #{players[0].avatar} et #{players[1].name.capitalize} aka #{players[1].avatar}"
    @current_game_show.waiting

  
    #(@current_game.board.is_winner? == false || ) 
    while @current_game.board.is_full? == false
      system('clear')
      @current_game_show.show_board_game(current_game)
      #self.show_board #=> affiche le board
      self.who_is_playing #=> affiche a qui de joueur
      self.player_choice #=> choix du joeur et traitement de l'info
      break if @current_game.board.is_winner? == true
      self.change_run #=> ajout un tour a @run

    end
    system('clear')
    @current_game_show.show_board_game(current_game)
    if @current_game.board.is_full? == false
      puts "\u{2728} \u{1F389} nous avons un vainqueur \u{1F37E} \u{2728}"
    else
      puts "\u{1F91D} C'est un match nul"
    end
  end

# --------------------------------------------------------------------

  # def show_board
  #   ShowGame.new.show_board_game(current_game)
  # end

  # def welcome_message
  #   ShowGame.new.welcome_message
  # end

  # def show_board_rules
  #   ShowGame.new.show_board_rules
  # end

  # def waiting
  #   ShowGame.new.waiting
  # end

  # affiche a quel joueur c'est de jouer
  #calculer en fonction du % de @run selon al position de chaque joueur (1 ou 2)

  def who_is_playing
    if current_game.run % 2 == 1
      #system('clear')
      puts "\n#{players[0].avatar} c'est à toi, dans quelle case joues-tu ?"
    else
      #system('clear')
      puts "\n#{players[1].avatar} c'est à toi, dans quelle case joues-tu ?"
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
        puts "\u{2622} \u{1F615} la case choisie est déjà occupée, choisie en une autre"
        self.player_choice
      end
    else
      puts "\u{26D4} \u{1F92C} La commande entrée ne correspond a aucune case du board, essaie encore"
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