class IoMock:

  def __init__(self):
    self.output = "blah"

  def write(self, output):
    self.output = output

  def readline(self):
    return "5"
