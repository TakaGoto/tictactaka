Given /^it is humans turn$/ do
end

When /^I make a move$/ do
  human = TakaTicTacToe::Human.new('X')
end

Then /^The move is displayed on board$/ do
  board = TakaTicTacToe::Board.new
  board.set_move('X',1)
  board.is_filled(1)
end

Given /^it is computers turn$/ do
end

When /^it makes a move$/ do
  ai = TakaTicTacToe::Computer.new('O', 'X')
  ai.set_difficulty(TakaTicTacToe::ImpossibleAi)
  ai.make_move
end

Then /^the move is displayed on board$/ do
  board = TakaTicTacToe::Board.new
  board.set_move('O',2)
  board.is_filled(2)
end
