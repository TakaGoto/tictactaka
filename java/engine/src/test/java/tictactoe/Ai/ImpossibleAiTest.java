package tictactoe.Ai;

import com.tictactoe.Ai.ImpossibleAi;
import com.tictactoe.Board.Board;
import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;

import static junit.framework.Assert.assertEquals;

public class ImpossibleAiTest {
    Board board;
    ImpossibleAi ai;

    @Before public void initialize(){
        board = new Board(3);
        ai = new ImpossibleAi('O');
    }

    @Test public void minimaxReturnsTen(){
        int[] winMoves = {1, 2, 3};
        board.setMoves('O', winMoves);
        assertEquals(10, ai.findValue(board));
    }

    @Test public void negascoutReturnsNegativeTen(){
        int[] winMoves = {1, 2, 3};
        board.setMoves('X', winMoves);
        assertEquals(-10, ai.findValue(board));
    }

    @Test public void negascoutReturnsZero(){
        board.setMoves('O', new int[]{1, 3, 5, 8});
        board.setMoves('X', new int[]{2, 4, 6, 7, 9});
        assertEquals(0, ai.findValue(board));
    }

    @Test public void negascoutReturnsLossNineAfterMove(){
        board.setMoves('X', new int[]{1, 3, 7, 8});
        board.setMoves('O', new int[]{2, 4, 5});
        assertEquals(-9, ai.findValue(board));
    }

    @Test public void negascoutGetsForcedLoss(){
        board.setMoves('X', new int[]{1, 2, 4, 6, 8, 9});
        board.setMoves('O', new int[]{3});
        assertEquals(-9, ai.findValue(board));
    }

    @Test public void findValueReturnsWinningMove(){
        board.setMoves('X', new int[]{1, 3, 7, 9});
        board.setMoves('O', new int[]{4, 5});
        assertEquals(6, ai.findMove(board));
    }

    @Test public void minimaxMakesSmartMove(){
        board.setMoves('X', new int[]{5, 9});
        board.setMoves('O', new int[]{1});
        assertEquals(3, ai.findMove(board));
    }

    @Test public void negascoutMakesGoodMove(){
        board.setMoves('X', new int[]{1});
        assertEquals(5, ai.findMove(board));
    }
}

