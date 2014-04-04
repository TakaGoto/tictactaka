from mocks.board_mock import BoardMock
from mocks.io_mock    import IoMock
from src.cli          import Cli

import unittest

class TestCli(unittest.TestCase):

  def setUp(self):
    self.cli = Cli(IoMock())

  def testCliPrintsBoard(self):
    self.cli.prompt_board(BoardMock())

    output = self.cli.io.output

    self.assertIn('1', output)

  def testCliAsksForMove(self):
    expected = 'Please enter your move: '
    self.cli.ask_move()

    output = self.cli.io.output

    self.assertEqual(expected, output)

  def testCliPromptsGoodBye(self):
    expected = 'Good bye!'
    self.cli.prompt_good_bye()

    output = self.cli.io.output

    self.assertEqual(expected, output)

  def testCliPromptsWelcome(self):
    expected = 'Welcome!'
    self.cli.prompt_welcome()

    output = self.cli.io.output

    self.assertEqual(expected, output)

  def testReturnsUserInput(self):
    expected = '5'
    user_input = self.cli.ask_move()

    self.assertEqual(expected, user_input)
