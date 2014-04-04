import unittest
from src.board import Board

class TestBoard(unittest.TestCase):

  def setUp(self):
    self.board = Board(3)

  def testItCreatesAThreeByThreeBoard(self):
    expected = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

    self.assertEquals(expected, self.board.slots)

  def testItReplacesSlot(self):
    index, mark = '5', 'X'
    self.board.replace_slot(index, mark)

    self.assertEquals(mark, self.board.slots.pop(int(index)-1))
