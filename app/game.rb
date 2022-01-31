# frozen_string_literal: true
require_relative 'player'
require_relative 'deck'

# === Game ===
class Game
  MIN_DECK_SIZE = 20
  BET_VALUE = 10
  @@bank = 0 # TODO: Not sure that really need this var

  def start_game
    dealer = Player.new('Dealer', true)
    puts 'Say your name, player'
    name = gets.chomp
    player = Player.new(name, false)
    puts "Game start here, #{player.name}"
    deck = Deck.new
    loop do
      puts "*** \nPlayer bank: #{player.bank}$, Dealer bank: #{dealer.bank}$ \n***"
      continue(player)
      deck = refresh_deck(deck)
      deck.cards
      player.first_take(deck)
      dealer.first_take(deck)
      get_bets(player, dealer)
      player_turn(player, dealer, deck)
    end
  end

  private

  def get_bets(player, dealer)
    if player.bank < 10 || dealer.bank < 10
      puts 'Seems like one of the players have balance that is less than 10 dollars, the game is over'
      exit
    end

    player.bank -= BET_VALUE
    dealer.bank -= BET_VALUE
    @@bank += BET_VALUE * 2
  end

  def player_turn(player, dealer, deck)
    if player.full_hand? && dealer.full_hand?
      puts 'Player and dealer have 3 cards, opening cards'
      winner(player, dealer)
      return
    end

    puts 'What you want to do?'
    player_options.each do |option|
      puts option
    end
    choice = gets.chomp.to_i
    case choice
    when 1
      dealer_turn(player, dealer, deck)
    when 2
      player.take_card(deck)
      dealer_turn(player, dealer, deck)
    when 3
      winner(player, dealer)
    else
      puts 'Wrong option, please try again'
      player_turn(player, dealer, deck)
    end
  end

  def player_options
    [
      '- Press 1 to skip',
      '- Press 2 to get another card',
      '- Press 3 to open cards'
    ]
  end

  def open_cards(player)
    puts "#{player.name} has #{player.current_hand.keys} cards, value of cards is #{player.current_hand_points}"
  end

  def dealer_turn(player, dealer, deck)
    dealer.take_card(deck) if dealer.current_hand_points < 17 && !dealer.full_hand?
    player_turn(player, dealer, deck)
  end

  def winner(player, dealer)
    open_cards(player)
    open_cards(dealer)

    if (player.current_hand_points > 21 && dealer.current_hand_points > 21) || (player.current_hand_points == dealer.current_hand_points)
      player.bank += @@bank / 2
      dealer.bank += @@bank / 2
      @@bank = 0
      player.clear_hand
      dealer.clear_hand
      puts 'It is draw'
    elsif ((player.current_hand_points > dealer.current_hand_points) && player.current_hand_points <= 21) || (player.current_hand_points <= 21 && dealer.current_hand_points > 21)
      player.bank += @@bank
      @@bank = 0
      player.clear_hand
      dealer.clear_hand
      puts 'You won!'
    else
      dealer.bank += @@bank
      @@bank = 0
      player.clear_hand
      dealer.clear_hand
      puts 'You lost :('
    end
  end

  def continue(player)
    puts "#{player.name}, do you want to continue? Press '1' if yes, another button if no"
    choice = gets.chomp.to_i
    if choice == 1
      return
    else
      puts 'Thanks for game, goodbye'
      exit
    end
  end

  def refresh_deck(deck)
    if deck.cards.size < MIN_DECK_SIZE
      puts 'Deck was refreshed'
      Deck.new
    else
      deck
    end
  end
end
