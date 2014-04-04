package com.tictactoe.Player;

import com.tictactoe.Ai.ImpossibleAi;
import com.tictactoe.Board.Board;

public class ComputerPlayer implements Player {
    public char mark;

    public ComputerPlayer(char mark) {
        this.mark = mark;
    }

    public char getMark() {
        return mark;
    }

    public boolean isHuman() {
        return false;
    }

    public Board move(Board board, int index) {
        ImpossibleAi ai = new ImpossibleAi(mark);
        int move = ai.findMove(board);
        board.setMove(mark, move);
        return board;
    }
}
