# frozen_string_literal: true

require_relative 'hand'
require_relative 'interface'

# === Player ===
class Player
  attr_reader :name, :hand, :is_dealer
  attr_accessor :bank

  def initialize(name, is_dealer)
    @is_dealer = is_dealer
    @bank = 100
    @name = name
    @hand = Hand.new

    @interface = Interface.new
  end

  def first_take(deck)
    @interface.handing_out(self)
    2.times do
      hand.take_card(deck, self)
    end
  end
end
