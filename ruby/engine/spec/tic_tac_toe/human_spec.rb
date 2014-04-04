require 'spec_helper'

describe TakaTicTacToe::Human do
  let(:human) {human = described_class.new('X')}
  describe "#new" do
    it "should create an object player with a mark" do
      human.mark.should eq('X')
    end
  end

  it "should make a move on the board" do
    board = game_board.new
    human.make_move(1, board)
  end
end



