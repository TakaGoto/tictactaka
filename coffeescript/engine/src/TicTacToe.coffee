class TicTacToe
  @play: (setup) ->
    new TicTacToe(setup)

  @makeMove: (setup) ->
    game = new TicTacToe(setup)
    game.board.placeMark(setup.nextMove, game.playerOne.mark.char)
    game

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
