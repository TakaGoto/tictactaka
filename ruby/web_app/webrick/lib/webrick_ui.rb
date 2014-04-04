class WEBrickUI
  attr_reader :messages

  def self.messages
    @messages ||= {}
  end

  def self.display_message
    messages[:message] = "Your move! Have fun!"
  end

  def self.print_board(board)
    messages[:board] = board.slots
  end

  def self.ask_move(player)
    turn_player = player.mark == 'X' ? "player one" : "player two"
    messages[:message] = "Your move #{turn_player}"
  end

  def self.error
    messages[:message] = "Error"
  end

  def self.display_result(result)
    messages[:message] = "It is a tie!" if result == "tie"
    messages[:message] = "Winner is #{result}" if result != "tie"
  end
end
