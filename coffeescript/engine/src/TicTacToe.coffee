class TicTacToe
  @play: (setup) ->
    new TicTacToe(setup)

  @makeMove: (setup) ->
    game = new TicTacToe(setup)
    mark = @determineNextMark(setup)
    game.board.placeMark(setup.nextMove, mark)
    game

  @determineNextMark: (setup) ->
    emptySpaces = 0

    for char in setup.board
      if char == setup.emptySpace
        emptySpaces++

    if emptySpaces % 2 == 0
      return setup.playerTwo.mark
    else
      return setup.playerOne.mark

  constructor: (setup) ->
    @board = Board.fromString(setup.board)
    @board.emptySpace = setup.emptySpace
    @board.marks = [setup.playerOne.mark, setup.playerTwo.mark]
    @playerOne = new Player(setup.playerOne)
    @playerTwo = new Player(setup.playerTwo)

  isOver: ->
    for mark in @board.marks
      if Rules.isOver(@board.toString(), mark) || Rules.isTie(@board.toString())
        return true

    return false
