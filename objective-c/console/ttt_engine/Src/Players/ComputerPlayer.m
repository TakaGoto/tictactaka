#import "ComputerPlayer.h"
#import "../Ui/Ui.h"
#import "../board.h"
#import "Ai.h"

@implementation ComputerPlayer

@synthesize mark;

- (id) init:(NSString*)m {
    if (self = [super init]) {
        self.mark = m;
    }
    return (self);
}

- (NSMutableArray*) makeMoveWith:(Board*)board andUi:(id<Ui>)ui {
    [board replaceSlot:[Ai getMove:board withMark:self.mark] withMark:self.mark];
    return board.slots;
}

@end
