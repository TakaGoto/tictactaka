#import "HumanPlayer.h"
#import "../board.h"
#import "../Ui/Ui.h"

@implementation HumanPlayer

@synthesize mark;

- (id) init:(NSString*)m {
    if (self = [super init]) {
        self.mark = m;
    }
    return (self);
}

- (NSMutableArray*) makeMoveWith:(Board*)board andUi:(id<Ui>)ui {
    NSString *userInput = [ui promptMove];
    
    while (![board validSlot:[userInput intValue]]) {
        [ui printBoard:board];
        userInput = [ui promptMoveAgain];
    }
    
    [board replaceSlot:[userInput intValue]-1 withMark:self.mark];
    return board.slots;
}

@end
