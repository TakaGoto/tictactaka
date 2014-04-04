Feature: Human makes a move
  As a human player
  I want to make a move
  So the move will be displayed on the board

  Scenario: Human makes move
    Given it is humans turn
    When I make a move
    Then the move is displayed on board
