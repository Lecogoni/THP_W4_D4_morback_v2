class Player

  attr_accessor :name, :position, :symbol

  def initialize(name, position)
    @name = name
    @position = position
    @symbol = (position == 1 ? "x" : "o")
  end

  def show_player
    #system('clear')
    if @position == 1
      puts "le joueur #{@position} : #{@name.capitalize} a le symbol #{symbol}. Il débutera la partie"
    else
      puts "le joueur #{@position} : #{@name.capitalize} a le symbol #{symbol}."
    end
  end

end