function Game(ui) {
  this.ui = ui;

  this.start = function() {
    this.ui.welcomePlayer();

    this.createBoard();
    this.createPlayerOne();
    this.createPlayerTwo();
  }

  this.end = function() {
    this.ui.farewellPlayer();
  }

  this.createBoard = function() {
    boardSize = this.ui.askBoardSize();
    this.board = new Board(boardSize);
  }

  this.createPlayerOne = function() {
    playerType = this.ui.askPlayerOneType();
    this.playerOne = new Player("X", playerType, ui);
  }

  this.createPlayerTwo = function() {
    playerType = this.ui.askPlayerTwoType();
    this.playerTwo = new Player("O", playerType, ui);
  }
}
