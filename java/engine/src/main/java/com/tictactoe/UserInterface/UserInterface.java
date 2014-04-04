package com.tictactoe.UserInterface;

import com.tictactoe.Board.Board;

public interface UserInterface {
    void welcomeMessage();
    void endGame();
    void printBoard(Board board);
    void displayResult(String result);

    String askPlayerOneOption();
    String askPlayerTwoOption();
    String getPlayerOptionInput();
    String getBoardOptionInput();

    int askBoardOption();
    int askPlayerMove();

    boolean askContinue();
}
