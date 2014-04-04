#import <Foundation/Foundation.h>
#import "../../ttt_engine/Src/Ui/IO.h"
#import "../../ttt_engine/Src/Ui/Ui.h"

@interface ConsoleUi : NSObject <Ui>

@property (nonatomic, strong) id<IO> io;

- (id) init:(id<IO>)io;

- (void) welcomeUser;

- (void) promptGoodBye;

- (void) printBoard:(Board *)board;

- (void) promptResult:(NSString *)gameState;

- (NSString*) promptMoveAgain;

- (NSString*) promptBoardSize;

- (NSString*) promptMove;

- (NSString*) promptPlayerOneType;

- (NSString*) promptPlayerTwoType;

- (BOOL) promptPlayAgain;

- (BOOL) validateInput:(NSString*)input with:(NSArray*)match;

@end
