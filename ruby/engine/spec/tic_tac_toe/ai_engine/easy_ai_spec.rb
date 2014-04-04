require 'spec_helper'

describe TakaTicTacToe::AiEngine::EasyAi do
  let(:board) {game_board.new}
  let(:mark) {'O'}

  describe "#make_move" do
    context "return the first empty slot available" do
      it "returns 1 for an empty board" do
        described_class.make_move(board, mark).should == "1"
      end

      it "returns 2 when player makes a move on 1" do
        board.set_move('X', 1)
        described_class.make_move(board, mark).should == "2"
      end

      it "returns 5 when the first 4 slots are filled" do
        board.set_move('O', 1)
        board.set_move('X', 2)
        board.set_move('O', 3)
        board.set_move('X', 4)
        described_class.make_move(board, mark).should == "5"
      end
    end
  end
end
