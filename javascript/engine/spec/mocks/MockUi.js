function MockUi() {
  this.welcomedPlayer = false;
  this.farewelledPlayer = false;
  this.stubbedBoardSize = 3;
  this.stubbedPlayerOneType = "human";
  this.stubbedPlayerTwoType = "computer";

  this.welcomePlayer = function() {
    this.welcomedPlayer = true;
  }

  this.farewellPlayer = function() {
    this.farewelledPlayer = true;
  }

  this.askBoardSize = function() {
    return this.stubbedBoardSize;
  }

  this.askPlayerOneType = function() {
    return this.stubbedPlayerOneType;
  }

  this.askPlayerTwoType = function() {
    return this.stubbedPlayerTwoType;
  }
}
