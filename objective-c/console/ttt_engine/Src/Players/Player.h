#import <Foundation/Foundation.h>
#import "../Ui/Ui.h"
#import "../board.h"

@protocol Player

@property (nonatomic, strong) NSString* mark;

- (id) init:(NSString*)mark;

- (NSMutableArray*) makeMoveWith:(Board*)board andUi:(id<Ui>)ui;

@end
