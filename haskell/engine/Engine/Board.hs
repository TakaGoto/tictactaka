module Engine.Board where

empty = " "

isFull board = all (empty/=) board
