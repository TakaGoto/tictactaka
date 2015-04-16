class Board
  @fromString: (board_string) ->
    board_size = Math.sqrt(board_string.length)
    board = new Board(board_size)

    for char, index in board_string.split("")
      board.placeMark(index + 1, char)

    board

  constructor: (size) ->
    board_size = Math.pow(size, 2)
    @slots = new Array(board_size)

  placeMark: (position, mark) ->
    @slots[position - 1] = mark

  horizontalCombinations: ->
    return [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
