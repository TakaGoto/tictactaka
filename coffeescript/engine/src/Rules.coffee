class Rules
  @isOver: (boardString, mark) ->
    board = Board.fromString(boardString)
    winningCombinations =
      board.diagonalSlots()
        .concat(board.horizontalSlots())
        .concat(board.verticalSlots())

    for combinations in winningCombinations
      slots = board.getSlots(combinations)

      if (slots[0] == slots[1]) &&
         (slots[1] == slots[2]) &&
         slots[0] == mark
        return true

    return false
