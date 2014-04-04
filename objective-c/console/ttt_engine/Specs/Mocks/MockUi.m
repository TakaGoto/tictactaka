#import "IO.h"
#import "MockUi.h"
#import "Ui.h"

@implementation MockUi

@synthesize welcomedUser;
@synthesize promptedGoodBye;
@synthesize promptedMove;
@synthesize promptedBoardSize;
@synthesize promptedPlayerOneType;
@synthesize promptedPlayerTwoType;
@synthesize promptedPlayAgain;
@synthesize promptedTie;
@synthesize promptedWinner;
@synthesize promptedMoveAgain;

- (id) init:(id<IO>)io {
    if (self = [super init]) {
        self.io = io;
    }
    return (self);
}

- (void) welcomeUser {
    self.welcomedUser = YES;
}

- (void) promptGoodBye {
    self.promptedGoodBye = YES;
}

- (void) printBoard:(Board *)board {
    self.printedBoard = YES;
}

- (void) promptResult:(NSString *)gameState {
    if ([gameState isEqualToString:@"tie"]) {
        self.promptedTie = YES;
    } else {
        self.promptedWinner = YES;
    }
}

- (NSString*) promptMoveAgain {
    promptedMoveAgain = YES;
    return @"2";
}

- (NSString*) promptMove {
    self.promptedMove = YES;
    return @"5";
}

- (NSString*) promptBoardSize {
    self.promptedBoardSize = YES;
    return @"3";
}

- (NSString*) promptPlayerOneType {
    self.promptedPlayerOneType = YES;
    return @"h";
}

- (NSString*) promptPlayerTwoType {
    self.promptedPlayerTwoType = YES;
    return @"h";
}

- (BOOL) promptPlayAgain {
    self.promptedPlayAgain = YES;
    return NO;
}

- (BOOL) validateInput:(NSString *)input with:(NSArray *)word {
    return false;
}

@end