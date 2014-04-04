from src.player import Player
from mocks.board_mock import BoardMock

import unittest
import mocks.board_mock as board_mock

class TestPlayer(unittest.TestCase):

  def testPlayerHasAFirstPlayerMark(self):
    player = Player('X')

    self.assertEquals('X', player.mark)

  def testPlayerHasASecondPlayerMark(self):
    player = Player('O')

    self.assertEquals('O', player.mark)

  def testPlayerMakesAMove(self):
    player = Player('X')
    board = BoardMock()
    player.make_move("5", board)

    self.assertEquals(True, board.check_move_played)

