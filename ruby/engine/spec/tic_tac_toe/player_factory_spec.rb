require 'spec_helper'

def impossible_ai
  TakaTicTacToe::AiEngine::ImpossibleAi
end

describe TakaTicTacToe::PlayerFactory do
  let(:player_factory) {described_class}
  it "should create a computer with the right difficulty" do
    input = {type: :computer, mark: :O, opponent_mark: :X,  difficulty: impossible_ai}
    player = player_factory.create(input)
    player.should be_an_instance_of(TakaTicTacToe::Computer)
    player.mark.should == :O
  end

  it "should create a human" do
    input = {type: :human, mark: :X}
    player = player_factory.create(input)
    player.should be_an_instance_of(TakaTicTacToe::Human)
    player.mark.should == :X
  end

  it "returns a raise if the input is incorrect" do
    input = {type: :frog, mark: :P}
    expect {player_factory.create(input)}.to raise_error("unknown player type")
  end
end
