class Board
  @fromString: (boardString) ->
    boardSize = Math.sqrt(boardString.length)
    board = new Board(size: boardSize)

    for char, index in boardString.split("")
      board.placeMark(index + 1, char)

    board

  constructor: (options) ->
    @emptySpace = options.emptySpace
    @marks = options.marks
    @slots = @buildSlots(options.size)

  buildSlots: (size) ->
    boardSize = Math.pow(size, 2)
    slots = new Array(boardSize)
    for slot, index in slots
      slots[index] = @emptySpace

    slots

  placeMark: (position, mark) ->
    @slots[position - 1] = mark

  getSlot: (position) ->
    @slots[position - 1]

  getSlots: (positions) ->
    marks = []

    for position in positions
      marks = marks.concat(@getSlot(position))

    marks

  toString: ->
    @slots.join("")

  emptySpaces: ->
    count = 0

    for slot in @slots
      if slot == @emptySpace
        count++

    count

  horizontalSlots: ->
    return [
      [1, 2, 3]
      [4, 5, 6]
      [7, 8, 9]
    ]

  verticalSlots: ->
    return [
      [1, 4, 7]
      [2, 5, 8]
      [3, 6, 9]
    ]

  diagonalSlots: ->
    return [
      [1, 5, 9]
      [3, 5, 7]
    ]
