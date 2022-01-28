# frozen_string_literal: true
require_relative 'player'
require_relative 'deck'

# === Game ===
class Game
  puts 'Say your name, player'
  name = gets.chomp
  player = Player.new(name)
  Deck.new
end
