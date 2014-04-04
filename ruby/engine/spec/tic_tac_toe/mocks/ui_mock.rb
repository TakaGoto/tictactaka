class UiMock
  attr_reader :welcomed_players, :asked_player_again,
              :get_value, :displayed_message,
              :asked_move, :board_printed, :checked_game_state,
              :ask_continue, :end_game_message, :computer_moved,
              :displayed_result, :asked_board_option,
              :asked_player_one_type, :asked_player_two_type

  def output
    $stdout
  end

  def ask_player_one_type
    @asked_player_one_type = true
    :computer
  end

  def ask_player_two_type
    @asked_player_two_type = true
    :human
  end

  def ask_board_option
    @asked_board_option = true
    4
  end

  def display_result(result)
    @displayed_result = true
  end

  def error
    @error = true
  end

  def end_game_message
    @end_game_message = true
  end

  def computer_move
    @computer_moved = true
  end

  def continue?
    @ask_continue = true
    false
  end

  def print_board(board)
    @board_printed = true
  end

  def ask_move(player)
    @asked_move = true
    @move = "5"
  end

  def display_message
    @displayed_message = true
  end

  def reset_board
    @board_reset = true
  end

  def display_board(board)
    @displayed_board = board
  end

  def start_game
    @welcomed_players = true
  end

  def ask_play_again
    @asked_player_again = true
  end
end
