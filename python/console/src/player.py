class Player:

  def __init__(self, mark):
    self.mark = mark

  def make_move(self, index, board):
    board.replace_slot(index, self.mark)
