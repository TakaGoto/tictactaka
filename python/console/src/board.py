class Board:

  def __init__(self, size):
    self.slots = self.__create_slots(size)

  def __create_slots(self, size):
    return ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

  def replace_slot(self, index, mark):
    self.slots.insert(self.__parse_int(index), mark)

  def __parse_int(self, string):
    return int(string) - 1

