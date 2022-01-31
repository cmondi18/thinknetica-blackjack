# frozen_string_literal: true

# === Player ===
class Player
  attr_reader :name, :current_hand
  attr_accessor :bank

  def initialize(name, is_dealer)
    @is_dealer = is_dealer
    @bank = 100
    @name = name
    @current_hand = {}
  end

  def take_card(deck)
    if @current_hand.size == 3 && !@is_dealer
      puts 'You have 3 cards and can\'t get another one'
      return
    end
    card = deck.card
    @current_hand = @current_hand.merge(card)
    if @is_dealer
      puts 'Dealer received card [?]'
    else
      puts "You get card. Your cards is/are: #{@current_hand.keys}, value of cards is #{current_hand_points}"
    end
  end

  def current_hand_points
    sum = 0
    aces = []
    # first iteration to collect sum of the all 'normal' values
    @current_hand.each_value do |value|
      if value.is_a?(Array)
        aces << value
      else
        sum += value
      end
    end
    # then go with aces to check better value
    check_aces(sum, aces)
  end

  def first_take(deck)
    puts "...Handing out cards to #{name}"
    2.times do
      take_card(deck)
    end
  end

  def full_hand?
    return true if current_hand.size == 3

    false
  end

  def clear_hand
    @current_hand = {}
  end

  private

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
