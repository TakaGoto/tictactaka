Feature: check state of game
    Check if the game is done
    by winner or by tie, and check

  Scenario:
    Given game has begun
    When there is a winner or a tie
    Then the game is over

