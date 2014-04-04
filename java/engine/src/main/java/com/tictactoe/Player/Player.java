package com.tictactoe.Player;

import com.tictactoe.Board.Board;

public interface Player {
    char getMark();
    boolean isHuman();
    Board move(Board board, int index);
}
