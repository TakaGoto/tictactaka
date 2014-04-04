class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message
  end
end
def output
  @output ||= Output.new
end


Given /^I am not yet playing$/ do
end

When /^I start a new game$/ do
  game = TakaTicTacToe::Game.new
  game.play
end

Then /^I should see "(.*?)"$/ do |message|
  output.messages.should include(message)
end

Given /^the game is done$/ do
  game = TakaTicTacToe::Game.new
  game.is_over?
end

When /^player types in yes to play again$/ do
  game = TakaTicTacToe::Game.new
  game.continue?
end

Then /^the game should restart$/ do
  game = TakaTicTacToe::Game.new
  game.play if game.continue?
end

Given /^the game is finished$/ do
  game = TakaTicTacToe::Game.new
  game.finished
end

When /^the player types no to play again$/ do
  game = TakaTicTacToe::Game.new
  if game.continue?
    game.play
  else
    game.finished
  end
end

Then /^the game should end$/ do
  game = TakaTicTacToe::Game.new
  game.finished
end
