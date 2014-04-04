package tictactoe.mocks;

import com.tictactoe.Board.Board;
import com.tictactoe.UserInterface.UserInterface;

import java.util.Scanner;

public class UiMock implements UserInterface {
    public Scanner input;

    public UiMock(Readable reader) {
        input = new Scanner(reader);
    }

    public void welcomeMessage() {
    }

    public void endGame() {
    }

    public String askPlayerOneOption() {
        return "human";
    }

    public String askPlayerTwoOption() {
        return "human";
    }

    public int askBoardOption() {
        return 3;
    }

    public String getPlayerOptionInput() {
        return "";
    }

    public String getBoardOptionInput() {
        return "";
    }

    public boolean askContinue(){
        return false;
    }

    public int askPlayerMove(){
        return Integer.parseInt(input.nextLine());
    }

    public void printBoard(Board board){
    }

    public void displayResult(String result) {
    }
}
