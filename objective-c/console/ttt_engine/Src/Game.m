#import "Game.h"
#import "BoardLogic.h"
#import "Players/PlayerFactory.h"

@implementation Game

- (id) initWithUi:(id)ui {
    if ((self = [super init])) {
        self.ui = ui;
    }
    return (self);
}

- (void) createBoard {
    int boardSize = [[[self ui] promptBoardSize] intValue];
    self.board = [[Board alloc] init:boardSize];
}

- (void) createPlayerOne {
    NSString *playerType = [[self ui] promptPlayerOneType];
    self.playerOne = [PlayerFactory create:playerType withMark:@"X"];
}

- (void) createPlayerTwo {
    NSString *playerType = [[self ui] promptPlayerTwoType];
    self.playerTwo = [PlayerFactory create:playerType withMark:@"O"];
}

- (void) play {
    [self startGame];

    while (![BoardLogic isOver:self.board]) {
        [self playGame];
    }

    [self endGame];
}

- (void) startGame {
    [[self ui] welcomeUser];

    [self setUpGame];
}

- (void) setUpGame {
    [self createBoard];
    [self createPlayerOne];
    [self createPlayerTwo];
}

- (void) playGame {
    [[self ui] printBoard:self.board];
    [self makePlayerMove:self.playerOne];

    if (![BoardLogic isOver:self.board]) {
        [[self ui] printBoard:self.board];
        [self makePlayerMove:self.playerTwo];
    }
}

- (void) makePlayerMove:(id<Player>)player {
    self.board.slots = [player makeMoveWith:self.board andUi:self.ui];
}

- (void) endGame {
    [[self ui] printBoard:self.board];
    [[self ui] promptResult:[BoardLogic gameState:self.board]];

    if ([[self ui] promptPlayAgain]) {
        [self play];
    }
    [[self ui] promptGoodBye];
}

@end
