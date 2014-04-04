#!/bin/sh
set -e

cd ttt_console
pod install
xctool -workspace console_ttt.xcworkspace -scheme specs
