#import <Foundation/Foundation.h>
#import "src/ConsoleIO.h"
#import "src/ConsoleUi.h"
#import "../ttt_engine/Src/Game.h"
#import "../ttt_engine/Src/BoardLogic.h"

int main(int argc, const char * argv[]) {
  ConsoleIO *io = [[ConsoleIO alloc] init];
  ConsoleUi *ui = [[ConsoleUi alloc] init:io];
  Game *game = [[Game alloc] initWithUi:ui];

  @autoreleasepool {
    [game play];
  }
  return 0;
}


