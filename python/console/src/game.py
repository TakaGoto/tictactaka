import src.board  as board
import src.player as player

class Game:

  def __init__(self, ui, settings):
    self.ui = ui
    self.board      = board.Board(settings['board_size'])
    self.player_one = player.Player(settings['player_one'])
    self.player_two = player.Player(settings['player_two'])

  def start_game(self):
    self.ui.prompt_welcome()

  def make_move(self):
    self.ui.prompt_board()
    self.ui.ask_move()

  def end_game(self):
    self.ui.prompt_good_bye()
