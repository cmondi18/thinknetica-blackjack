# === Card ===
class Card
  attr_reader :symbol_n_suit, :value

  def initialize(symbol_n_suit, value)
    @symbol_n_suit = symbol_n_suit
    @value = value
  end
end
