#import <Foundation/Foundation.h>
#import "../board.h"
#import "IO.h"

@protocol Ui

- (id) init:(id<IO>)io;

- (void) welcomeUser;

- (void) promptGoodBye;

- (void) promptResult:(NSString*)gameState;

- (void) printBoard:(Board*)board;

- (NSString*) promptMoveAgain;

- (NSString*) promptMove;

- (NSString*) promptBoardSize;

- (NSString*) promptPlayerOneType;

- (NSString*) promptPlayerTwoType;

- (BOOL) promptPlayAgain;

- (BOOL) validateInput:(NSString*)input with:(NSArray*)match;

@end
