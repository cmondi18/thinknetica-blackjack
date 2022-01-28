# frozen_string_literal: true
require_relative 'player'
require_relative 'deck'

# === Game ===
class Game
  dealer = Player.new('Dealer', true)
  puts 'Say your name, player'
  name = gets.chomp
  player = Player.new(name, false)
  puts "Game start here, #{player.name}"
  deck = Deck.new
  puts "*** \nPlayer bank: #{player.bank}$, Dealer bank: #{dealer.bank}$ \n***"
  puts '...Handing out cards to player'
  puts "Your cards are #{deck.card}, #{deck.card}"
  puts '...Handing out cards to dealer'
  2.times { deck.card }
  'Dealer received his cards *, *'
end
