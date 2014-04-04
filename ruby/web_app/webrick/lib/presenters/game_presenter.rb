class GamePresenter
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
end
