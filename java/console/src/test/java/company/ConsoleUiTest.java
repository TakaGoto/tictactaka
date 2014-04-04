package company;

import com.company.ConsoleUi;
import com.tictactoe.Board.Board;
import org.junit.Before;
import org.junit.Test;

import java.io.*;

import static junit.framework.Assert.assertEquals;
import static junit.framework.Assert.assertFalse;
import static junit.framework.Assert.assertTrue;

public class ConsoleUiTest {

    private ByteArrayOutputStream output = new ByteArrayOutputStream();
    ConsoleUi ui;

    @Before
    public void initialize(){
        System.setOut(new PrintStream(output));
        Reader reader = new StringReader("4\n5\n6\n7");
        ui = new ConsoleUi(reader);
    }

    @Test public void welcomesPlayerToGame(){
        ui.welcomeMessage();
        assertEquals("Welcome to Tic Tac Toe!\n", output.toString());
    }

    @Test public void outputEndGame(){
        ui.endGame();
        assertEquals("Thanks for playing! Good bye.\n", output.toString());
    }

    @Test public void askForPlayerOneOption(){
        ui.askUserPlayerOption("one");
        assertEquals("Please enter player one type('h' or 'c'): \n", output.toString());
    }

    @Test public void askForPlayerTwoOption(){
        ui.askUserPlayerOption("two");
        assertEquals("Please enter player two type('h' or 'c'): \n", output.toString());
    }

    @Test public void askForBoardSizeOption(){
        ui.askBoardOption();
        assertEquals("Player enter board size(3 or 4): \n", output.toString());
    }

    @Test public void UserInputWrongBoard() {
        Reader reader = new StringReader("1\n3\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals(3, ui.askBoardOption());
    }

    @Test public void getPlayerOptionInput(){
        assertTrue(ui.getPlayerOptionInput().matches("4"));
    }

    @Test public void getBoardOptionInput(){
        System.out.println(ui.getBoardOptionInput());
        assertTrue(ui.getBoardOptionInput().matches("5"));
    }

    @Test public void askPlayerTwoHumanOption(){
        Reader reader = new StringReader("h\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals("h", ui.askPlayerTwoOption());
    }

    @Test public void askPlayerTwoComputerOption(){
        Reader reader = new StringReader("c\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals("c", ui.askPlayerTwoOption());
    }

    @Test public void askPlayerTwoWrongOption(){
        Reader reader = new StringReader("u\nc\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals("c", ui.askPlayerTwoOption());
    }

    @Test public void askPlayerMove() {
        Reader reader = new StringReader("u\n5\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals(5, ui.askPlayerMove());
    }

    @Test public void askWrongPlayerMove() {
        Reader reader = new StringReader("u\n5\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals(5, ui.askPlayerMove());
    }

    @Test public void askBoardOption(){
        Reader reader = new StringReader("4\n3\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals(4, ui.askBoardOption());
    }

    @Test public void wrongBoardInput() {
        Reader reader = new StringReader("u\n3\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals(3, ui.askBoardOption());
    }

    @Test public void TwoWrongBoardInput() {
        Reader reader = new StringReader("u\n6\n3");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals(3, ui.askBoardOption());
    }

    @Test public void askPlayerOneWrongOption(){
        Reader reader = new StringReader("u\nc\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals("c", ui.askPlayerOneOption());
    }

    @Test public void askPlayerOneHumanOption(){
        Reader reader = new StringReader("h\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals("h", ui.askPlayerOneOption());
    }

    @Test public void askPlayerOneComputerOption(){
        Reader reader = new StringReader("c\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals("c", ui.askPlayerOneOption());
    }

    @Test public void askContinueReturnsYes() {
        Reader reader = new StringReader("Y\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals(true, ui.askContinue());
    }

    @Test public void askContinueReturnsNo() {
        Reader reader = new StringReader("N\n");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals(false, ui.askContinue());
    }

    @Test public void askContinueReturnsWrongInput() {
        Reader reader = new StringReader("u\nN");
        ConsoleUi ui = new ConsoleUi(reader);
        assertEquals(false, ui.askContinue());
    }

    @Test public void askToContinue() {
        ui.askUserContinue();
        assertEquals("Would you like to play again? Y/N: \n", output.toString());
    }

    @Test public void askForPlayerMove(){
        ui.askPlayerMove();
        assertEquals("Enter your move: \n", output.toString());
    }

    @Test public void printBoard(){
        Board board = new Board(3);
        ui.printBoard(board);
        assertTrue(output.toString().contains("1"));
        assertTrue(output.toString().contains("2"));
        assertTrue(output.toString().contains("3"));
        assertTrue(output.toString().contains("4"));
        assertTrue(output.toString().contains("5"));
        assertTrue(output.toString().contains("6"));
        assertTrue(output.toString().contains("7"));
        assertTrue(output.toString().contains("8"));
        assertTrue(output.toString().contains("9"));
    }

    @Test public void printBoardWithMoves(){
        Board board = new Board(3);
        board.setMove('X', 5);
        ui.printBoard(board);
        assertFalse(output.toString().contains("5"));
    }

    @Test public void displayResult(){
        ui.displayResult("tie");
        assertEquals("Game over! It is a tie\n", output.toString());
    }

    @Test public void displayResultWhenWinner(){
        ui.displayResult("X");
        assertEquals("Game over! X has won!\n", output.toString());
    }
}
