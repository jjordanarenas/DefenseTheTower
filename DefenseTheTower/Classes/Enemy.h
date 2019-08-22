#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PathStep.h"
#import "Defense.h"

@interface Enemy : CCNode {
    
}

// Property for the sprite
@property (readwrite, nonatomic) CCSprite *enemySprite;
// Property for the life points
@property (readwrite, nonatomic) int lifePoints;
// Property for the path step
@property (readwrite, nonatomic) PathStep *pathStep;
// Property for the attacking defenses
@property (readwrite, nonatomic) NSMutableArray *attackingDefenses;
// Property for the scene
@property (readwrite, nonatomic) GameScene *gameScene;

// Declare init method
- (Enemy *) initEnemyWithPathStep:(PathStep *)step andScene:(GameScene *)scene;
// Declare add attacker method
- (void) addAttackingDefense:(Defense *)attackingDefense;
// Declare out of range method
- (void) outOfRangeFromDefense:(Defense *)attacker;

@end
