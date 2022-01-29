# frozen_string_literal: true

# === Deck ===
# TODO: Do we need to reset deck when cards are finished or reset it each game?
class Deck
  HIGHER_CARDS = {
    king: 10,
    queen: 10,
    jack: 10,
    ace: [1, 11]
  }.freeze

  SUITS = %W[\u2664 \u2661 \u2667 \u2662].freeze

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

  def card
    card = @@cards.slice(@@cards.keys[rand(@@cards.size)])
    @@cards.delete(card)
    card
  end
end
