class ShowGame
  
  def show_board_game(current_game)
    for i in 0..2 do
      puts "-------------"
      for j in 0..2 do
        print "| #{current_game.board.boardcase[i][j].content} "
      end
      puts "|"
    end
    puts "-------------"
  end
  
  def show_board_rules
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
  end
  puts "indique la cellule dans laquel tu souhaites jouer par son numéro"
end