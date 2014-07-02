describe("Game", function() {
  var ui = new MockUi();
  var game = new Game(ui);

  it("welcomes the player", function() {
    game.start();

    expect(game.ui.welcomedPlayer).toBeTrue;
  });

  it("creates a board", function() {
    game.start();

    expect(game.board.boardSize).toEqual(ui.stubbedBoardSize);
  });

  it("creates first player", function() {
    game.start();

    expect(game.playerOne.mark).toEqual("X");
    expect(game.playerOne.type).toEqual(ui.stubbedPlayerOneType);
  });

  it("creates second player", function() {
    game.start();

    expect(game.playerTwo.mark).toEqual("O");
    expect(game.playerTwo.type).toEqual(ui.stubbedPlayerTwoType);
  });

  it("prompts farewell to the player", function() {
    game.end();

    expect(game.ui.farewelledPlayer).toBeTrue;
  });
});
