#!/bin/sh
set -e

cd ttt_engine
pod install
xctool -workspace OCTicTacToe.xcworkspace -scheme Specs
