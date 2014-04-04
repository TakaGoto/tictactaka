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

Given /^game has begun$/ do
  board = TakaTicTacToe::Board.new
  player_one = TakaTicTacToe::Human.new('X')
  player_two = TakaTicTacToe::Computer.new(player_one.mark)
end

When /^there is a winner or a tie$/ do
  board = TakaTicTacToe::Board.new
  board.full? || board.has_winner
end

Then /^the game is over$/ do
  board = TakaTicTacToe::Board.new
  if board.full? || board.has_winner
    board.winner
  end
end

