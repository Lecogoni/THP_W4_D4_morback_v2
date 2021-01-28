require 'rubygems'

class Launch

  attr_accessor :players, :nbr_of_game, :current_game, :avatar_choice, :current_game_show, :draw, :final_answer

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
    @avatar_choice = ["\u{1F60E}", "\u{1F921}", "\u{1F47B}", "\u{1F47D}", "\u{1F916}", "\u{1F637}" ]
    @draw = 0
    @current_game_show = ShowGame.new
    @current_game_show.welcome_message
    @nbr_of_game = 0
    @players = []
    
    for i in 1..2 do
      players << Player.new(ask_player_name(i), i, player_avatar(i))
      system('clear')
    end
    @current_game_show.show_board_rules
    #@players.each {|player| player.show_player}
    
    puts ""
    puts "Quand tu es prêt appuie sur n'importe quelle touche \u{1F21A} \u{1F21A} \u{1F21A} pour commencer \u{25B6}"
    gets.chomp

    self.launch_game

  end

# ------------------- DEF QUI LANCE LE JEU UNE FOIS LES PLAYERS DEFINIE ----------------------------
# ---------- cree un Game.new qui a son tour créer Board.new > Boarcase.new / ShowGame.new---------------

  def launch_game
    @nbr_of_game += 1
    @current_game = Game.new(players)
    system('clear')
    puts "\n\nLet's go !!! - partie #{nbr_of_game} - #{players[0].name.capitalize} aka #{players[0].avatar} \u{1F19A} #{players[1].name.capitalize} aka #{players[1].avatar}"
    puts ""
    @players.each {|player| player.show_player}
    puts ""
    @current_game_show.waiting
    puts ""
    self.switch_player_or_play_menu(@current_game_show.switch_player_or_play_show)



# ------------------- Boucle WHILE lancement jeu ---------------

    while @current_game.board.is_full? == false
      system('clear')
      @current_game_show.show_board_game(current_game)

      self.who_is_playing #=> affiche a qui de joueur
      self.player_choice #=> choix du joeur et traitement de l'info
      break if @current_game.board.is_winner? == true
      self.change_run #=> ajout un tour a @run
    end

# ------------------- fin de Boucle affichage résultat ---------------

    system('clear')
    @current_game_show.show_board_game(current_game)
    if @current_game.board.is_full? == false
      puts "\u{2728} \u{1F389} \u{1F37E} nous avons un vainqueur \u{1F389} \u{1F37E} \u{2728}"
      self.winner_is
      @current_game_show.congrats_message
    else
      puts "\u{1F91D} C'est un match nul"
      self.its_a_draw
    end

    self.resume_games
    sleep 6

# ------------------- Menu de fin de partie ---------------
    
    system('clear')
    @final_answer = @current_game_show.final_menu
    self.final_menu_choice(final_answer)
  end


# ------------------- Def ---------------

  # Affiche qui joue

  def who_is_playing
    who_play = current_game.run % 2
    if players[0].position == who_play
      puts "\n#{players[0].avatar} c'est à toi, dans quelle case joues-tu ?"
    else
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
        puts "\u{1F615} la case choisie est déjà occupée, choisie en une autre"
        self.player_choice
      end
    else
      puts "\u{26D4} \u{1F92C} La commande entrée ne correspond a aucune case du board, essaie encore"
      @current_game_show.show_board_rules_reminder
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

  # change la valeur du nbre de match nul

  def its_a_draw
    @draw += 1
  end

  # permet de savoir quel joueur a gagner et lui ajouter un point de victoire a @win

  def winner_is
    win_number = current_game.run % 2
    if win_number == 1
      players[0].win += 1
      puts "\u{2728} \u{2728} \u{2728} \u{2728} Congrats #{players[0].avatar} #{players[0].name.upcase} #{players[0].avatar} \u{2728} \u{2728} \u{2728} \u{2728}"
    else
      players[1].win += 1
      puts "\u{2728} \u{2728} \u{2728} \u{2728} Congrats #{players[1].avatar} #{players[1].name.upcase} #{players[1].avatar} \u{2728} \u{2728} \u{2728} \u{2728}"
    end
  end

  # affiche un recap du nombre de partie - draw - win

  def resume_games
    puts "\u{2728} ça fait #{nbr_of_game} partie - #{draw} match null \u{2728} #{players[0].name.capitalize} #{players[0].avatar} a #{players[0].win} victoire #{players[1].name.capitalize} #{players[1].avatar} a #{players[1].win} \u{2728}"
  end
  
  # fetch a random quote

  def randow_quotes
    response = HTTParty.get('http://quotes.stormconsultancy.co.uk/random.json')
    quo = response.body
    quote = quo.split('"')[9]
  end

  # menu de changement de position des joueurs

  def switch_player_or_play_menu(player_answer)
    case player_answer
    when "y"
      self.switch_player_position
      @players.each {|player| player.show_player}
      puts ""
      @current_game_show.waiting
      puts ""
      self.switch_player_or_play_menu(@current_game_show.switch_player_or_play_show)
    when "n"
      puts "\n\nLet's go !!! - partie #{nbr_of_game} - #{players[0].name.capitalize} aka #{players[0].avatar} \u{1F19A} #{players[1].name.capitalize} aka #{players[1].avatar}"
      @players.each {|player| player.show_player}
    else
      puts "Ah pas compris ton choix \u{1F624} \u{1F616} \u{1F641}"
      self.switch_player_or_play_menu(@current_game_show.switch_player_or_play_show)
    end
  end

  # execution du choix du menu final

  def final_menu_choice(final_answer)
    case final_answer
    when 1
      self.launch_game
    when 2
      puts ""
      system("ruby app.rb")
    when 3
        puts "Et voilà :"
        puts self.randow_quotes
        answer = @current_game_show.final_menu
        self.final_menu_choice(answer)
    when 4
      puts "bye bye !!!"
      system("exit")
    else
      puts "\u{1F621} soit tu ne fais pas attention quand tu tapes soit tu n'as rien compris "
      @final_answer = @current_game_show.final_menu
    end
  end

  # execution changement de position des joueurs - change position, symbol, position dans l'array

  def switch_player_position
    @players.each {|player| player.switch_player_position}
    player_switch = players[0]
    players.shift
    players.push(player_switch)
  end

end