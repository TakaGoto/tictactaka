from src.game      import Game
from src.player    import Player
from src.board     import Board
from mocks.ui_mock import UiMock

import unittest

SETTINGS = {'board_size': 3, 'player_one': 'X', 'player_two': 'O'}

class TestGameInstances(unittest.TestCase):

  def setUp(self):
    self.ui = UiMock()
    self.game = Game(self.ui, SETTINGS)

  def testGameHasAUserInterface(self):
    self.assertIsInstance(self.game.ui, type(self.ui))

  def testGameHasABoard(self):
    board = self.game.board

    self.assertIsInstance(board, Board)
    self.assertEquals(9, len(board.slots))

  def testGameHasPlayerOne(self):
    player = self.game.player_one

    self.assertIsInstance(player, Player)
    self.assertEqual('X', player.mark)

  def testGameHasPlayerTwo(self):
    player = self.game.player_two

    self.assertIsInstance(player, Player)
    self.assertEqual('O', player.mark)

class TestGameUi(unittest.TestCase):

  def setUp(self):
    self.ui = UiMock()
    self.game = Game(self.ui, SETTINGS)

  def testGamePromptsWelcome(self):
    self.game.start_game()

    self.assertEqual(True, self.game.ui.prompted_welcome)

  def testGamePromptsGoodBye(self):
    self.game.end_game()

    self.assertEqual(True, self.game.ui.prompted_good_bye)

  def testGamePromptsForMove(self):
    self.game.make_move()

    self.assertEqual(True, self.game.ui.prompted_user_for_move)

  def testGamePrintsBoard(self):
    self.game.make_move()

    self.assertEqual(True, self.game.ui.prompted_board)
