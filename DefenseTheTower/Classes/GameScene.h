#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enemy.h"
#import "Defense.h"

@interface GameScene : CCScene {
}

// Property for array of enemies
@property (readwrite, nonatomic) NSMutableArray *enemies;
// Property for batch node
@property (readwrite, nonatomic) CCSpriteBatchNode *batchNode;

+ (GameScene *)scene;
- (id)init;
- (void)enemyReachedTower;
@end
