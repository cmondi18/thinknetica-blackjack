# frozen_string_literal: true

require_relative 'card'
# === Deck ===
class Deck
  attr_reader :cards

  HIGHER_CARDS = {
    king: 10,
    queen: 10,
    jack: 10,
    ace: [1, 11]
  }.freeze

  SUITS = %W[\u2664 \u2661 \u2667 \u2662].freeze

  def initialize
    @cards = []

    SUITS.each do |suit|
      HIGHER_CARDS.each do |card|
        @cards << Card.new(card[0].to_s + suit, card[1])
      end
      (2..10).each do |card|
        @cards << Card.new(card.to_s + suit, card)
      end
    end
  end

  def card
    card = @cards.sample
    @cards.delete(card)
    card
  end
end
