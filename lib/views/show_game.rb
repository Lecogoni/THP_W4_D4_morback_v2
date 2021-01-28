class ShowGame
  
  def initialize
  end

  # affichage du board avec les bonnes valeurs 
  def show_board_game(current_game)
    puts "#{current_game.players[0].name.capitalize} #{current_game.players[0].avatar} #{current_game.players[0].symbol} \u{1F19A} #{current_game.players[1].name.capitalize} #{current_game.players[1].avatar} #{current_game.players[1].symbol}"
    puts ""
    for i in 0..2 do
      puts "----------------"
      for j in 0..2 do
        print "| #{current_game.board.boardcase[i][j].content} "
      end
      puts "|"
    end
    puts "----------------"
  end
  
  # tableau de comment jouer
  def show_board_rules
    system('clear')
    puts "Comment jouer - je suis sur que tu connais les règles !!"
    puts "A ton tour tu auras juste à entrer le numéro de la case - entre 1 et 9 - dans laquelle tu souhaites jouer"
    puts ""
    cell_number = 1
    for i in 0..2 do
      puts "-------------"
      for j in 0..2 do
        print "| #{cell_number} "
        cell_number += 1
      end
      puts "|"
    end
    puts "-------------"
    puts ""
  end

    # tableau de comment jouer - rappel
    def show_board_rules_reminder
      puts "il suffit juste de choisir une case vide entre 1 et 9 !"
      cell_number = 1
      for i in 0..2 do
        puts "-------------"
        for j in 0..2 do
          print "| #{cell_number} "
          cell_number += 1
        end
        puts "|"
      end
      puts "-------------"
    end

  # ASCII art message - message de lancement
  def welcome_message
    system('clear')
    puts " _   _      _ _   "
    sleep 0.1
    puts "| | | | ___| | | ___ "
    sleep 0.1
    puts "| |_| |/ _   | |/ _ \ "
    sleep 0.1
    puts "|  _  |  __/ | | (_) |"
    sleep 0.1
    puts "|_| |_| ___|_|_| ___/ "
    sleep 0.1
    puts "" 
    puts "bienvenue dans mon jeu du morpion"
    puts "\nAvant de commencer entre le nom des deux joueurs qui vont s'affronter"
  end

  # ASCII art message - en cas de gagnant
  def congrats_message
    puts "                  ___________"
    sleep 0.1
    puts "                 '._==_==_=_.'"
    sleep 0.1
    puts "                 .-\:      /-."
    sleep 0.1
    puts "                | (|:.     |) |"
    sleep 0.1
    puts "                 '-|:.     |-'"
    sleep 0.1
    puts "                   \::.    /"
    sleep 0.1
    puts "                    '::. .'"
    sleep 0.1
    puts "                      ) ("
    sleep 0.1
    puts "                    _.' '._"
    sleep 0.1
    puts '                   `"""""""`'
  end

  # Menu demandant si on veut intervertir la position des joueurs
  def switch_player_or_play_show
    puts ""
    puts "Souhaites tu intervertir \u{1F504} la position des joueurs ? y - n"
    gets.chomp
  end

  # simple affichage
  def waiting
    30.times do
      print "."
      sleep 0.1
    end
    sleep 0.2
  end
  
  # menu de fin de partie
  def final_menu
    puts ""
    puts ""
    puts "Que veux tu faire ?"
    puts ""
    puts "\u{1F3B2} on prend les mêmes et on recommence : 1"
    puts "\u{1F3AE} on repart de zéro avec des nouveaux joueurs : 2"
    puts "\u{1F914} sinon pour patienter le temps que tu réfléchisses je peux te proposer une citation ! : 3"
    puts "\u{1F480} bye bye on ferme : 4"
    puts ""
    print ">> "
    final_answer = gets.chomp.to_i
  end

end



  
