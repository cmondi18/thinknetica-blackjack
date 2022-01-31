# === Interface ===
class Interface
  MESSAGES = {
    enter_name: 'Say your name, player',
    game_start: 'Game is starting',
    new_line: '***',
    balance: 'balance is',
    continue: 'Do you want to continue? Press \'1\' if yes, another button if no',
    thx_for_game: 'Thanks for game, goodbye',
    nil_balance: 'Seems like one of the players have balance that is less than 10 dollars, the game is over',
    three_cards: 'Player and dealer have 3 cards, opening cards',
    wrong_option: 'Wrong option, please try again',
    draw: 'It is draw',
    won: 'You won!',
    lost: 'You lost :(',
    refresh_deck: 'Deck was refreshed'
  }.freeze

  PLAYER_OPTIONS = {
    option1: '- Press 1 to skip',
    option2: '- Press 2 to get another card',
    option3: '- Press 3 to open cards'
  }.freeze

  def message(message)
    puts MESSAGES[message]
  end

  def user_input
    gets.chomp
  end

  def balance(player, dealer)
    puts "***\n#{player.name} #{MESSAGES[:balance]} #{player.bank}, #{dealer.name} #{MESSAGES[:balance]} #{dealer.bank} \n***"
  end

  def what_to_do
    puts 'What you want to do?'
    PLAYER_OPTIONS.each_value do |option|
      puts option
    end
  end

  def open_cards(player)
    puts "#{player.name} has #{player.current_hand.keys} cards, value of cards is #{player.current_hand_points}"
  end
end
