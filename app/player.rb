# frozen_string_literal: true

# === Player ===
class Player
  attr_reader :bank, :name

  def initialize(name, is_dealer)
    @is_dealer = is_dealer
    @bank = 100
    @name = name
  end
end
