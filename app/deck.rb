# frozen_string_literal: true

# === Deck ===
class Deck
  HIGHER_CARDS = {
    king: 10,
    queen: 10,
    jack: 10,
    ace: [1, 11]
  }.freeze

  SUITS = %w[+ <3 <> ^].freeze

  @@cards = {

  }

  def initialize
    SUITS.each do |suit|
      HIGHER_CARDS.each do |card|
        @@cards[card[0].to_s + suit] = card[1]
      end
      (2..10).each do |card|
        @@cards[card.to_s + suit] = card
      end
    end
  end
end
