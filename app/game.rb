# frozen_string_literal: true

require_relative 'player'
require_relative 'deck'
require_relative 'interface'

# === Game ===
class Game
  MIN_DECK_SIZE = 20
  BET_VALUE = 10

  def initialize
    @bank = 0
    @interface = Interface.new
  end

  def start_game
    dealer = Player.new('Dealer', true)
    interface.message :enter_name
    name = interface.user_input
    player = Player.new(name, false)
    interface.message :start_game
    deck = Deck.new
    loop do
      interface.balance(player, dealer)
      continue
      deck = refresh_deck(deck)
      deck.cards
      player.first_take(deck)
      dealer.first_take(deck)
      get_bets(player, dealer)
      player_turn(player, dealer, deck)
    end
  end

  private

  attr_reader :interface

  def get_bets(player, dealer)
    if player.bank < 10 || dealer.bank < 10
      interface.message :nil_balance
      exit
    end

    player.bank -= BET_VALUE
    dealer.bank -= BET_VALUE
    @bank += BET_VALUE * 2
  end

  def player_turn(player, dealer, deck)
    if player.hand.full? && dealer.hand.full?
      interface.message :three_cards
      winner(player, dealer)
      return
    end

    interface.what_to_do
    choice = interface.user_input.to_i
    case choice
    when 1
      dealer_turn(player, dealer, deck)
    when 2
      player.take_card(deck)
      dealer_turn(player, dealer, deck)
    when 3
      winner(player, dealer)
    else
      interface.message :wrong_option
      player_turn(player, dealer, deck)
    end
  end

  def dealer_turn(player, dealer, deck)
    dealer.take_card(deck) if dealer.hand.points < 17 && !dealer.hand.full?
    player_turn(player, dealer, deck)
  end

  def winner(player, dealer)
    interface.open_cards(player)
    interface.open_cards(dealer)

    if draw?(player, dealer)
      player.bank += @bank / 2
      dealer.bank += @bank / 2
      interface.message :draw
    elsif win?(player, dealer)
      player.bank += @bank
      interface.message :won
    else
      dealer.bank += @bank
      interface.message :lost
    end
    reset(player, dealer)
  end

  def draw?(player, dealer)
    (player.hand.points > 21 && dealer.hand.points > 21) || (player.hand.points == dealer.hand.points)
  end

  def win?(player, dealer)
    ((player.hand.points > dealer.hand.points) && player.hand.points <= 21) || (player.hand.points <= 21 && dealer.hand.points > 21)
  end

  def reset(player, dealer)
    @bank = 0
    player.hand.clear
    dealer.hand.clear
  end

  def continue
    interface.message :continue
    choice = interface.user_input.to_i
    return nil if choice == 1

    interface.message :thx_for_game
    exit
  end

  def refresh_deck(deck)
    if deck.cards.size < MIN_DECK_SIZE
      interface.message :refresh_deck
      Deck.new
    else
      deck
    end
  end
end
