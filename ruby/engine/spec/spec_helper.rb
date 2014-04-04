require 'taka_tic_tac_toe'

def create_board(board)
  TakaTicTacToe::Board.parse(board)
end

def game_board
  TakaTicTacToe::Board
end
