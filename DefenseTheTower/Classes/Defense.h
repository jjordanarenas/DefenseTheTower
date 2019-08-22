#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Enemy;
@class GameScene;

typedef enum {
    levelOne = 0,
    levelTwo
} DefenseLevel;
@interface Defense : CCNode {
    
}

// Property for defense level
@property (readwrite, nonatomic) DefenseLevel *defenseLevel;
// Property for the sprite
@property (readwrite, nonatomic) CCSprite *defenseSprite;
// Property for the attack points
@property (readwrite, nonatomic) int attackPoints;
// Property for the enemy in range
@property (readwrite, nonatomic) Enemy *enemyInRange;
// Property for the scene
@property (readwrite, nonatomic) GameScene *gameScene;

// Declare init method
-(Defense *) initDefenseWithLevel:(DefenseLevel)level scene:(GameScene *)scene andPosition:(CGPoint)position;
- (void) enemyKilled;
@end
