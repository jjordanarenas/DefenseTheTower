#import "Enemy.h"

#define SPEED 5

@implementation Enemy

- (Enemy *) initEnemyWithPathStep:(PathStep *)step {
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
    
    return self;
}

- (void) setPosition:(CGPoint)position {
    _enemySprite.position = position;
    [super setPosition:position];
}

@end
