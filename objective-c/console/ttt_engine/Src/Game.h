#import <Foundation/Foundation.h>
#import "Ui/Ui.h"
#import "board.h"
#import "Players/Player.h"

@interface Game : NSObject

@property (nonatomic, strong) id<Ui> ui;
@property (nonatomic, strong) id<Player> playerOne;
@property (nonatomic, strong) id<Player> playerTwo;
@property (nonatomic, strong) Board* board;

- (id) initWithUi:(id<Ui>)ui;

- (void) createBoard;

- (void) createPlayerOne;

- (void) createPlayerTwo;

- (void) play;

- (void) startGame;

- (void) playGame;

- (void) endGame;

@end
