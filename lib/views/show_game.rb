class ShowGame
  
  def initialize
  end

  def show_board_game(current_game)
    puts "#{current_game.players[0].name.capitalize} #{current_game.players[0].avatar} : #{current_game.players[0].symbol} ; #{current_game.players[1].name.capitalize} #{current_game.players[1].avatar} : #{current_game.players[1].symbol}"
    for i in 0..2 do
      puts "----------------"
      for j in 0..2 do
        print "| #{current_game.board.boardcase[i][j].content} "
      end
      puts "|"
    end
    puts "----------------"
  end
  
  def show_board_rules
    system('clear')
    puts "Comment jouer - je suis sur que tu connais les règles !!"
    puts "A ton tour tu auras juste à entrer le numéro de la case - entre 1 et 9 - dans laquelle tu souhaites jouer"
    puts ""
    cell_number = 1
    for i in 0..2 do
      puts "-------"
      for j in 0..2 do
        print "|#{cell_number}"
        cell_number += 1
      end
      puts "|"
    end
    puts "-------"
    puts ""
  end

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

  def congrats_message
    puts "   ___________"
    puts "  '._==_==_=_.'"
    puts "  .-\:      /-."
    puts " | (|:.     |) |"
    puts "  '-|:.     |-'"
    puts "    \::.    /"
    puts "     '::. .'"
    puts "       ) ("
    puts "     _.' '._"
    puts '    `"""""""`'
  end

  def waiting
    50.times do
      print "."
      sleep 0.1
    end
    sleep 0.2
  end
  

end

  
