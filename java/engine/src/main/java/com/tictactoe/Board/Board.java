package com.tictactoe.Board;

import java.util.ArrayList;

public class Board {
      private int length;
      private String slots = "";

    public Board(int length) {
        this.length = length;
        createSlots();
    }

    public void createSlots() {
        for(int i = 0; i < Math.pow(length, 2); i++) slots += "_";
    }

    public void setMove(char mark, int index) {
        StringBuilder newSlots = new StringBuilder(slots);
        newSlots.setCharAt(index - 1, mark);
        slots = newSlots.toString();
    }

    public void setMoves(char mark, int[] index){
        for (int anIndex : index) {
            StringBuilder newSlots = new StringBuilder(slots);
            newSlots.setCharAt(anIndex - 1, mark);
            slots = newSlots.toString();
        }
    }

    public int getLength() {
        return length;
    }

    public String getSlots() {
        return slots;
    }

    public void setSlots(String newSlots) {
        slots = newSlots;
    }

    public ArrayList<Integer> getEmptySlots() {
        ArrayList<Integer> emptySlots = new ArrayList<Integer>(){};
        for(int i = 0; i < Math.pow(length, 2); i++) if ((slots.charAt(i) == '_')) emptySlots.add(i + 1);
        return emptySlots;
    }

    public void undoMove(int index) {
        StringBuilder newSlots = new StringBuilder(slots);
        newSlots.setCharAt(index-1, '_');
        slots = newSlots.toString();
    }

    public boolean isEmpty() {
        return slots.replaceAll("[_]", "").length() == 0;
    }

    public boolean moveIsValid(int move) {
        int boardLength = (int) Math.pow(length, 2);
        if(move > boardLength || move < 1) return false;
        else return true;
    }

    public void setMove(char mark, String move) {
        if(!(move == ""))
            setMove(mark, Integer.parseInt(move));
    }
}
