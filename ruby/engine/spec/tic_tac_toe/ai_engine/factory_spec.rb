require 'spec_helper'

describe TakaTicTacToe::AiEngine::Factory do
  it "makes an easy ai move" do
    move = {:difficulty => :easy_ai,
            :board => game_board,
            :mark => "O"}
    TakaTicTacToe::AiEngine::EasyAi.
      should_receive(:make_move).
      and_return("4")
    ai = described_class.get(move)
    ai.should == "4"
  end

  it "makes an impossible ai move" do
    move = {:difficulty => :impossible_ai,
            :board => game_board,
            :mark => "O"}
    TakaTicTacToe::AiEngine::ImpossibleAi.
      should_receive(:make_move).
      and_return("5")
    ai = described_class.get(move)
    ai.should == "5"
  end

  it "makes a medium ai move" do
    move = {:difficulty => :medium_ai,
            :board => game_board,
            :mark => "O"}
    TakaTicTacToe::AiEngine::MediumAi.
      should_receive(:make_move).
      and_return("5")
    ai = described_class.get(move)
    ai.should == "5"
  end
end
