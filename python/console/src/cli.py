class Cli:

  def __init__(self, io):
    self.io = io

  def ask_move(self):
    self.__write("Please enter your move: ")
    return self.io.readline()

  def prompt_board(self, board):
    self.__write(board.slot)

  def prompt_good_bye(self):
    self.__write("Good bye!")

  def prompt_welcome(self):
    self.__write("Welcome!")

  def __write(self, output):
    self.io.write(output)
