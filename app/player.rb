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
    card = deck.card
    @current_hand = @current_hand.merge(card)
    card
    if @is_dealer
      puts 'Dealer received card [?]'
    else
      puts "You get card. Your cards is/are: #{@current_hand.keys}, value of cards is #{current_hand_points}"
    end
  end

  def current_hand_points
    sum = 0
    @current_hand.each_value do |value|
      sum +=
        if value.is_a?(Array)
          check_ace(sum, value)
        else
          value
        end
    end
    sum
  end

  def first_take(deck)
    puts "...Handing out cards to #{name}"
    2.times do
      take_card(deck)
    end
  end

  private

  def check_ace(sum, ace_values)
    puts 'You got ACE!'
    return ace_values.max if sum + ace_values[0] <= 21 && sum + ace_values[1] <= 21
    return ace_values[0] if sum + ace_values[0] <= 21 && sum + ace_values[1] > 21
    return ace_values[1] if sum + ace_values[0] > 21 && sum + ace_values[1] <= 21
    return ace_values.min if sum + ace_values[0] > 21 && sum + ace_values[1] > 21
  end
end
