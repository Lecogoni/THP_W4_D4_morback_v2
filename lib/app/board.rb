class Board

  attr_accessor :boardcase

  # initialize créer un 2D array => [[5,5,5],[5,5,5],[5,5,5]] ou 
  #le contenu par default de chaque case du tableau est = BoardCase.new

  def initialize
    @boardcase = []
    for i in 0..2 do
      array = []
      for j in 0..2 do
        array << Boardcase.new
      end
      boardcase << array
    end
  end
  
  # Match nul : renvoie True si toutes les Boardcase != " " - True si le tableau est plein

  def is_full?
    for i in 0..2 do
      for j in 0..2 do
        return false if @boardcase[i][j].content == " "
      end
    end
    return true
  end

  # method qui definie les possibilité de victoire et renvoie true si l'une d'elle est satisfaite

  def is_winner?
    # ligne horizontal haut
    if (@boardcase[0][0].content == @boardcase[0][1].content) && (@boardcase[0][0].content == @boardcase[0][2].content)
      return true
    # ligne horizontal middle
    elsif (@boardcase[1][0].content == @boardcase[1][1].content) && (@boardcase[1][0].content == @boardcase[1][2].content)
      return true
    # ligne horizontal bas
    elsif (@boardcase[2][0].content == @boardcase[2][1].content) && (@boardcase[2][0].content == @boardcase[2][2].content)
      return true
    # ligne vertical gauche
    elsif (@boardcase[0][0].content == @boardcase[1][0].content) && (@boardcase[0][0].content == @boardcase[2][0].content)
      return true
    # ligne vertical middle
    elsif (@boardcase[0][1].content == @boardcase[1][1].content) && (@boardcase[0][1].content == @boardcase[2][1].content)
      return true
    # ligne vertical droit
    elsif (@boardcase[0][2].content == @boardcase[1][2].content) && (@boardcase[0][2].content == @boardcase[2][2].content)
      return true
    # diagonal 1
    elsif (@boardcase[0][0].content == @boardcase[1][1].content) && (@boardcase[0][0].content == @boardcase[2][2].content)
      return true
    # diagonal 2
    elsif (@boardcase[0][2].content == @boardcase[1][1].content) && (@boardcase[0][2].content == @boardcase[2][0].content)
      return true
    else
      return false
    end
  end


end