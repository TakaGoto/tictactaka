module Tests.Engine.Board where

import Engine.Board
import Test.HUnit

emptyBoard   = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
fullBoard    = ["o", "o", "x", "o", "x", "o", "x", "o", "x"]
midGameBoard = [" ", "o", "x", "o", " ", " ", "x", "x", "o"]

testEmptyBoard    = TestCase (assertEqual "returns false for empty board" (False) (isFull emptyBoard))
testFullBoard     = TestCase (assertEqual "returns true for full board" (True) (isFull fullBoard))
testNotEmptyBoard = TestCase(assertEqual "returns false for non empty not full board" (False) (isFull midGameBoard))

isFullMethod = TestList [
  TestLabel "Empty Board" testEmptyBoard,
  TestLabel "Full Board" testFullBoard,
  TestLabel "Not Empty Not Full Board" testNotEmptyBoard
  ]

suite = [ TestLabel "isFull" isFullMethod ]

main = runTestTT (TestList suite)
