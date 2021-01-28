class Game

  attr_accessor :board, :run, :players

  def initialize(players)
    @board = Board.new
    @players = players
    @run = 1
  end

  # check si la case est vide - si on peut jouer dedans

  def boardcase_is_empty?(choice_array)
    board.boardcase[choice_array[0]][choice_array[1]].content == "  "
  end

  # change la valeur de boardcase par le symbol du joueur calculé sur le run / tour en cour

  def change_boardcase(choice_array)
    value = run % 2
    if value == 1
      board.boardcase[choice_array[0]][choice_array[1]].content = players[0].symbol
    else
      board.boardcase[choice_array[0]][choice_array[1]].content = players[1].symbol
    end
  end

end