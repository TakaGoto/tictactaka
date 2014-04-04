require 'spec_helper'

describe TakaTicTacToe::AiEngine::MediumAi do
  let(:board) {game_board.new}
  let(:mark) {'O'}

  it "randomly chooses a number to figure out what move" do
    board = create_board('OXX456789')
    described_class.should_receive(:random_num)
    described_class.make_move(board, mark)
  end

  it "chooses an easy ai move when the random number is 0" do
    described_class.stub(:random_num).and_return(0)
    described_class.make_move(board, mark).should == "1"
  end

  it "chooses an impossible ai move when the random number is 1" do
    described_class.stub(:random_num).and_return(1)
    board = create_board('OX34X6789')
    described_class.make_move(board, mark).should == "8"
  end
end

