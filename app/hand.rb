require_relative 'interface'

# === Hand ===
class Hand
  attr_reader :current_hand

  def initialize
    @current_hand = []
    @interface = Interface.new
  end

  def take_card(deck, player)
    if @current_hand.size == 3 && !player.is_dealer
      interface.message :max_cards
      return
    end
    card = deck.card
    @current_hand << card
    if player.is_dealer
      interface.message :dealer_received
    else
      interface.player_card(player)
    end
  end

  def cards
    @current_hand.map(&:symbol_n_suit)
  end

  def points
    sum = 0
    aces = []
    # first iteration to collect sum of the all 'normal' values
    @current_hand.each do |card|
      if card.value.is_a?(Array)
        aces << card.value
      else
        sum += card.value
      end
    end
    # then go with aces to check better value
    check_aces(sum, aces)
  end

  def full?
    return true if @current_hand.size == 3

    false
  end

  def clear
    @current_hand = []
  end

  private

  attr_writer :current_hand
  attr_reader :interface

  # TODO: maybe there is an easier way?
  def check_aces(sum, aces)
    # aces[0][0] == 1, aces[0][1] == 11
    case aces.size
    when 0
      sum
    when 1
      sum +=
        if sum + aces[0][1] > 21
          aces[0][0]
        else
          aces[0][1]
        end
    when 2
      sum +=
        if sum + aces[0][1] + aces[1][0] > 21
          aces[0][0] + aces[1][0]
        else
          aces[0][1] + aces[1][0]
        end
    when 3
      sum = aces[0][1] + aces[1][0] + aces[2][0] # 13
    end
    sum
  end
end
