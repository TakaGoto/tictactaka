class BoardPresenter
  def self.generate_board(board)
    new_board = board.split('')
    size = board.size == 9 ? 3 : 4
    html_board = "<div style='width: #{size * 50}px;'>"
    new_board.each_index do |slot|
      value = new_board[slot] != '_' ? new_board[slot] : slot + 1
      html_board += "<form action='/player_move' method='post' style='float:left;'>"
      html_board += "<div style='width: 50px; length: 50px;'>"
      html_board += "<input type='submit' value=#{value} name='player_move'>"
      html_board += "</div>"
      html_board += "</form>"
    end
    html_board += "</div>"
  end

  def self.generate_message(message)
    html_message = "<h1>"
    html_message += message
    html_message += "</h1>"
  end

  def self.generate_play_again(board)
    new_board = TakaTicTacToe::Board.parse(board)
    html_output = "<p>"
    if new_board.is_tie || new_board.has_winner
      html_output += "play again?"
      html_output += "<a href='/'>yes</a>"
    end
    html_output += "</p>"
  end
end
