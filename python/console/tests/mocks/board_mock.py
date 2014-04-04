class BoardMock:

  def __init__(self):
    self.check_move_played = False
    self.slot = ["1", "2", "3", "4"]

  def replace_slot(self, index, mark):
    self.check_move_played = True
