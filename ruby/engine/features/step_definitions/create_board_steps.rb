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

Given /^game started$/ do
end

When /^the board is created$/ do
  board = TakaTicTacToe::Board.new
end

Then /^the board is empty$/ do
  board = TakaTicTacToe::Board.new
  board.is_empty?
end

