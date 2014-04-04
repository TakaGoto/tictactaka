class GameBind
  attr_reader :board, :binded, :message

  def initialize(board, message)
    @board = board
    @message = message
  end

  def get_binding
    @binded = true
    return binding()
  end
end
