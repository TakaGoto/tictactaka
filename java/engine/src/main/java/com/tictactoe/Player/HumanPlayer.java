package com.tictactoe.Player;

import com.tictactoe.Board.Board;

public class HumanPlayer implements Player {
    private char mark;

    public HumanPlayer(char mark) {
        this.mark = mark;
    }

    public boolean isHuman() {
        return true;
    }

    public char getMark() {
        return mark;
    }

    public Board move(Board board, int index) {
        board.setMove(mark, index);
        return board;
    }
}
