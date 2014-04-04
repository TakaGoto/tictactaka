require 'presenters/board_presenter'

describe BoardPresenter do
  it "generates a board" do
    board = '1234'
    erb_board = BoardPresenter.generate_board(board)
    erb_board.should include("1")
    erb_board.should include("form")
    erb_board.should include("input")
  end

  it "generates a message" do
    message = "message"
    erb_message = BoardPresenter.generate_message(message)
    erb_message.should include("message")
    erb_message.should include("h1")
  end

  describe "#generate_play_again" do
    it "generates play again message" do
      board = 'OOO456789'
      play_again = BoardPresenter.generate_play_again(board)
      play_again.should include("yes")
      play_again.should include("play")
      play_again.should include("again")
    end

    it "does not generate play again if game is not over" do
      board = 'OX3456789'
      play_again = BoardPresenter.generate_play_again(board)
      play_again.should_not include("again")
      play_again.should_not include("yes")
      play_again.should_not include("play")
    end
  end
end
