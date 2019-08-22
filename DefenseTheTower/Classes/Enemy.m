#import "Enemy.h"
#import "GameScene.h"

#define SPEED 5
// Number of defenses
#define NUM_DEFENSES 30

@implementation Enemy

- (Enemy *) initEnemyWithPathStep:(PathStep *)step andScene:(GameScene *)scene {

    self = [super init];
    if (!self) return(nil);
    
    // Initialize life points
    _lifePoints = 1;
    
    // Initialize sprite
    _enemySprite = [[CCSprite alloc] initWithImageNamed:@"DefenseTheTower/enemy.png"];
    
    // Set anchor point
    self.anchorPoint = CGPointMake(0.5, 0.5);
    _enemySprite.anchorPoint = CGPointMake(0.5, 0.5);
    
    // Set content size
    self.contentSize = CGSizeMake(_enemySprite.contentSize.width, _enemySprite.contentSize.height);
    
    // Set enemy position
    [self setPosition:step.position];

    // Initialize path step
    _pathStep = step;
    
    // Initialize array of defenses
    _attackingDefenses = [[NSMutableArray alloc] initWithCapacity:NUM_DEFENSES];

    _gameScene = scene;

    return self;
}

- (void) setPosition:(CGPoint)position {
    _enemySprite.position = position;
    [super setPosition:position];
}

- (void)update:(CCTime)delta {
    // Calculate distance to next step
    float distance = ccpDistance(_enemySprite.position, _pathStep.nextPathStep.position);
    // Set the movement speed
    float speed = SPEED;
    // Update speed if needed
    if (distance < speed ) {
        speed = distance;
    }
    
    if (distance > 0){
        if (self.position.y > _pathStep.nextPathStep.position.y){
            // Move down
            [self setPosition:CGPointMake(_enemySprite.position.x, _enemySprite.position.y - speed)];
        } else if (self.position.y < _pathStep.nextPathStep.position.y){
            // Move up
            [self setPosition:CGPointMake(_enemySprite.position.x, _enemySprite.position.y + speed)];
        } else if (self.position.x > _pathStep.nextPathStep.position.x){
            // Move left
            [self setPosition:CGPointMake(_enemySprite.position.x - speed, _enemySprite.position.y)];
        } else if (self.position.x < _pathStep.nextPathStep.position.x){
            // Move right
            [self setPosition:CGPointMake(_enemySprite.position.x + speed, _enemySprite.position.y)];
        }
    } else if (_pathStep.nextPathStep.nextPathStep != NULL){
        // Look for next step
        _pathStep = _pathStep.nextPathStep;
    } else {
        [_gameScene enemyReachedTower];
        // Enemy reached tower
        [self removeEnemyFromScene];
    }
    
    if (_lifePoints <= 0) {
        [self removeEnemyFromScene];
    }
}

- (void) addAttackingDefense:(Defense *)attackingDefense {
    [_attackingDefenses addObject:attackingDefense];
}

- (void) outOfRangeFromDefense:(Defense *)attacker {
    [_attackingDefenses removeObject:attacker];
}

- (void) removeEnemyFromScene {
    for (Defense *defense in _attackingDefenses) {
        [defense enemyKilled];
    }
    [_enemySprite removeFromParentAndCleanup:TRUE];
    [self removeFromParentAndCleanup:TRUE];
}

@end
