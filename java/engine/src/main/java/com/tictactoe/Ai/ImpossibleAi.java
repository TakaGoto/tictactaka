package com.tictactoe.Ai;

import com.tictactoe.Board.Board;
import com.tictactoe.Board.BoardLogic;

import java.util.ArrayList;

public class ImpossibleAi implements Ai {
    private BoardLogic gameLogic;
    private char mark;

    public ImpossibleAi(char mark) {
        this.mark = mark;
    }

    public int findMove(Board board) {
        char oppMark = getOppMark(mark);
        int bestScore = Integer.MIN_VALUE;
        int bestIndex = 0;

        ArrayList<Integer> emptySlots = board.getEmptySlots();
        for (Integer emptySlot : emptySlots) {
            board.setMove(mark, emptySlot);
            int score = miniMax(board, oppMark, 0, -1, false, Integer.MIN_VALUE, Integer.MAX_VALUE);
            board.undoMove(emptySlot);
            if (score > bestScore) {
                bestScore = score;
                bestIndex = emptySlot;
            }
        }
        return bestIndex;
    }

    public int findValue(Board board) {
        return miniMax(board, getOppMark(mark), 0, -1, false, Integer.MIN_VALUE, Integer.MAX_VALUE);
    }

    private int miniMax(Board board, char mark, int depth, int color, boolean max, int alpha, int beta) {
        char oppMark = getOppMark(mark);
        gameLogic = new BoardLogic(board);

        if(gameLogic.isOver() || depth == 7) return getGameScore(board, depth, mark) * color;
        else if(max) {
            ArrayList<Integer> emptySlots = board.getEmptySlots();
            for (Integer emptySlot : emptySlots) {
                board.setMove(mark, emptySlot);
                alpha = Math.max(alpha, miniMax(board, oppMark, depth + 1, -color, !max, alpha, beta));
                board.undoMove(emptySlot);
                if (alpha >= beta) break;
            }
            return alpha;
        } else {
            ArrayList<Integer> emptySlots = board.getEmptySlots();
            for (Integer emptySlot : emptySlots) {
                board.setMove(mark, emptySlot);
                beta = Math.min(beta, miniMax(board, oppMark, depth + 1, -color, !max, alpha, beta));
                board.undoMove(emptySlot);
                if (alpha >= beta) break;
            }
            return beta;
        }
    }

    private int getGameScore(Board board, int depth, char mark) {
        gameLogic = new BoardLogic(board);
        if (gameLogic.winner() == mark) return 10 + depth;
        else if (gameLogic.tie()) return 0;
        else return -10 + depth;
    }

    private char getOppMark(char mark) {
        if(mark == 'X') return 'O';
        else return 'X';
    }
}

