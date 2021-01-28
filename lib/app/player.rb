class Player

  attr_accessor :name, :position, :symbol, :avatar

  def initialize(name, position, avatar)
    @name = name
    @position = position
    @symbol = (position == 1 ? "\u{2705}" : "\u{274C}")   #(position == 1 ? "x" : "o")
    @avatar = avatar
  end

  def show_player
    #system('clear')
    if @position == 1
      puts "le joueur #{@position} : #{@name.capitalize} #{@avatar} a le symbol #{symbol}. Il débutera la partie"
    else
      puts "le joueur #{@position} : #{@name.capitalize} #{@avatar} a le symbol #{symbol}."
    end
  end

end