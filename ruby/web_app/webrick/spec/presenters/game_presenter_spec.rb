require './lib/presenters/game_presenter'

describe GamePresenter do
  describe "#generate_board" do
    it "generates a html board" do
      board = '____'
      html_board = described_class.generate_board(board)
      html_board.include?("1").should be_true
      html_board.include?("form").should be_true
      html_board.include?("input").should be_true
    end
  end
end
