# frozen_string_literal: true
require_relative 'player'
require_relative 'deck'

# === Game ===
class Game
  @@bank = 0 # TODO: Not sure that really need this var

  def start_game
    dealer = Player.new('Dealer', true)
    puts 'Say your name, player'
    name = gets.chomp
    player = Player.new(name, false)
    puts "Game start here, #{player.name}"
    deck = Deck.new
    puts "*** \nPlayer bank: #{player.bank}$, Dealer bank: #{dealer.bank}$ \n***"
    player.first_take(deck)
    dealer.first_take(deck)
    get_bets(player, dealer)
    player_turn
    choice = gets.chomp.to_i
    case choice
    when 1
      skip
    when 2
      player.take_card(deck)
    when 3
      winner(player, dealer)
    end
  end

  private

  def get_bets(player, dealer)
    if player.bank < 10 || dealer.bank < 10
      puts 'Seems like one of the players have balance that is less than 10 dollars, the game is over'
    end

    player.bank -= 10
    dealer.bank -= 10
    @@bank += 20
  end

  def player_turn
    puts 'What you want to do?'
    player_options.each do |option|
      puts option
    end
  end

  def player_options
    [
      '- Press 1 to skip',
      '- Press 2 to get another card',
      '- Press 3 to open cards'
    ]
  end

  def skip
    # skip
  end

  def open_cards(player)
    puts "#{player.name} has #{player.current_hand.keys} cards, value of cards is #{player.current_hand_points}"
  end

  def winner(player, dealer)
    open_cards(player)
    open_cards(dealer)

    if player.current_hand_points > dealer.current_hand_points
      puts 'You win!'
    elsif player.current_hand_points < dealer.current_hand_points
      puts 'It is draw'
    else
      puts 'You lost'
    end
  end
end
