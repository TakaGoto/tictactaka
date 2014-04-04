class UiMock:

  def __init__(self):
    self.prompted_welcome       = False
    self.prompted_good_bye      = False
    self.prompted_user_for_move = False
    self.prompted_board         = False

  def prompt_welcome(self):
    self.prompted_welcome = True

  def prompt_good_bye(self):
    self.prompted_good_bye = True

  def ask_move(self):
    self.prompted_user_for_move = True

  def prompt_board(self):
    self.prompted_board = True
