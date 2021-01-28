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