#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PathStep.h"

@interface Enemy : CCNode {
    
}

// Property for the sprite
@property (readwrite, nonatomic) CCSprite *enemySprite;
// Property for the life points
@property (readwrite, nonatomic) int lifePoints;
// Property for the path step
@property (readwrite, nonatomic) PathStep *pathStep;

// Declare init method
- (Enemy *) initEnemyWithPathStep:(PathStep *)step;
@end
