class Player

  attr_accessor :name, :position, :symbol, :win, :avatar

  def initialize(name, position, avatar)
    @name = name
    @position = position
    @symbol = (position == 1 ? "\u{2705}" : "\u{274C}")   #(position == 1 ? "x" : "o")
    @avatar = avatar
    @win = 0
  end

  # affiche les joueurs, leur symbol, avatar et position

  def show_player
    if @position == 1
      puts "le joueur #{@position} : #{@name.capitalize} #{@avatar} a le symbol #{symbol} il débutera la partie"
    else
      puts "le joueur #{@position} : #{@name.capitalize} #{@avatar} a le symbol #{symbol}"
    end
  end

  # switch la postion et le symbol des joueurs

  def switch_player_position
    if @position == 1
      @symbol = "\u{274C}"
      @position = 2
    elsif @position == 2
      @symbol = "\u{2705}"
      @position = 1
    end
  end

end