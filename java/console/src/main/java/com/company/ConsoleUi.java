package com.company;

import com.tictactoe.Board.Board;
import com.tictactoe.UserInterface.UserInterface;

import java.util.Scanner;

import static java.lang.System.out;

public class ConsoleUi implements UserInterface {
    private Scanner input;
    public int length;

    public ConsoleUi(Readable reader) {
        input = new Scanner(reader);
    }

    public void welcomeMessage() {
        out.println("Welcome to Tic Tac Toe!");
    }

    public void endGame() {
        out.println("Thanks for playing! Good bye.");
    }

    public String askPlayerOneOption() {
        askUserPlayerOption("two");
        String userInput = getPlayerOptionInput();
        while(invalidPlayerOptionInput(userInput)) {
            out.println("Please enter the right player type('h' or 'c'): ");
            userInput = getPlayerOptionInput();
        }
        return userInput;
    }

    public String askPlayerTwoOption() {
        askUserPlayerOption("two");
        String userInput = getPlayerOptionInput();
        while(invalidPlayerOptionInput(userInput)) {
            out.println("Please enter the right player type('h' or 'c'): ");
            userInput = getPlayerOptionInput();
        }
        return userInput;
    }

    public void askUserPlayerOption(String player) {
        out.println("Please enter player " + player + " type('h' or 'c'): ");
    }

    public boolean invalidPlayerOptionInput(String input) {
        return !input.toLowerCase().equals("h") && !input.toLowerCase().equals("c");
    }

    public int askBoardOption() {
        int userInput;
        out.println("Player enter board size(3 or 4): ");
        while(!input.hasNextInt()) {
            out.println("Please enter the right board size(3 or 4): ");
            input.next();
        }

        userInput = input.nextInt();

        while(userInput != 3 && userInput != 4) {
            out.println("Please enter the right board size(3 or 4): ");
            userInput = input.nextInt();
        }

        this.length =  userInput;
        return userInput;
    }

    public String getPlayerOptionInput() {
        return input.nextLine();
    }

    public String getBoardOptionInput() {
        return input.nextLine();
    }

    public int askPlayerMove() {
        out.println("Enter your move: ");
        while(!input.hasNextInt()) {
            out.println("Please enter the right move: ");
            input.next();
        }

        int userInput = input.nextInt();

//        while(userInput < 1 || userInput > (length * length)) {
//            out.println("Please enter the right move: ");
//            userInput = input.nextInt();
//        }

        return userInput;
    }

    public boolean askContinue() {
        askUserContinue();
        String userInput = input.nextLine().toLowerCase();
        while(!userInput.equals("n") && !userInput.equals("y")){
            out.println("please type in (y)es or (n)o: ");
            userInput = input.nextLine().toLowerCase();
        }
        return userInput.equals("y");
    }

    public void askUserContinue(){
        out.println("Would you like to play again? Y/N: ");
    }

    public void printBoard(Board board) {
        for(int i=1; i < board.getSlots().length() + 1; i++){
            if(board.getSlots().charAt(i-1) == '_') System.out.print(" " + i + " ");
            else System.out.print(" " + board.getSlots().charAt(i - 1) + " ");

            if (i % board.getLength() == 0) System.out.println();
        }
        System.out.println();
    }

    public void displayResult(String result) {
        if(result.equals("tie")) out.println("Game over! It is a tie");
        else out.println("Game over! " + result + " has won!");
    }
}

