class TicTacToe
  @play: (setup) ->
    new TicTacToe(setup)

  @makeMove: (setup) ->
    game = new TicTacToe(setup)

    if game.board.emptySpaces() % 2 != 0
      game.board.placeMark(setup.nextMove, game.playerOne.mark.char)

    console.log game.board.getSlot(1)
    game

  constructor: (setup) ->
    @board = Board.fromString(setup.board)
    @board.emptySpace = setup.emptySpace
    @playerOne = new Player(setup.playerOne?)
    @playerTwo = new Player(setup.playerTwo?)

  isOver: ->
    Rules.isOver(@board.toString(), "x")
