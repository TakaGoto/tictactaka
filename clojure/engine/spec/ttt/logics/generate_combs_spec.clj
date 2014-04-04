(ns ttt.logics.game-logic-spec
  (:require [speclj.core :refer :all])
  (:require [ttt.logics.generate-combs :refer :all]))

(describe "winning combinations"
  (context "row-combs"
    (it "returns the row winning combinations for 3x3"
      (should= [[0 1 2] [3 4 5] [6 7 8]] (row-combs 3)))

    (it "returns the row winning combinations for 4x4"
      (should= [[0 1 2 3] [4 5 6 7] [8 9 10 11] [12 13 14 15]]
        (row-combs 4)))
    (it "returns the row winning combinations for 5x5"
      (should= [[0 1 2 3 4] [5 6 7 8 9] [10 11 12 13 14] [15 16 17 18 19] [20 21 22 23 24]]
        (row-combs 5)))))

  (context "column-combs"
    (it "returns the column winning combinations for 3x3"
      (let [return (column-combs 3)]
      (should= [[0 3 6] [1 4 7] [2 5 8]] return)
      (should= clojure.lang.PersistentVector (class return))))

    (it "returns the column winning combinations for 4x4"
      (let [return (column-combs 4)]
        (should= [[0 4 8 12] [1 5 9 13] [2 6 10 14] [3 7 11 15]] return))))

  (context "diagonal-combs"
    (it "returns the diagonal winning combinations for 3x3"
      (let [return (diagonal-combs 3)]
        (should= [[0 4 8] [2 4 6]] return)))

    (it "returns the diagonal winning combinations for 4x4"
      (let [return (diagonal-combs 4)]
        (should= [[0 5 10 15] [3 6 9 12]] return))))

(context "get-all-combs"
  (it "should return a nested vector of all combinations"
    (should= [[0 1 2] [3 4 5] [6 7 8]
              [0 3 6] [1 4 7] [2 5 8]
              [0 4 8] [2 4 6]] (get-all-combs 3))))

