require 'bundler'
Bundler.require


$:.unshift File.expand_path("./../lib", __FILE__)

require 'app/game'
require 'app/board'
require 'app/boardcase'
require 'app/player'

require 'views/launch'
require 'views/show_game'

app = Launch.new




# app = Launch => contient le array de player et le game = Game.new
  # app.players
  #

# app.current_game.board.is_full?
# app.current_game.board.is_winner?