Feature: create a board
  As the game starts
  A board is created
  So that the players can make a move

  Scenario: create a board
    Given game started
    When the board is created
    Then the board is empty

