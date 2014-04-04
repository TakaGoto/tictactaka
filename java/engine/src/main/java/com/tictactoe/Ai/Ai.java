package com.tictactoe.Ai;

import com.tictactoe.Board.Board;

public interface Ai {
    int findMove(Board board);
    int findValue(Board board);
}
