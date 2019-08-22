#import "Defense.h"
#import "GameScene.h"

@implementation Defense

-(Defense *) initDefenseWithLevel:(DefenseLevel)level scene:(GameScene *)scene andPosition:(CGPoint)position {
    
    self = [super init];
    if (!self) return(nil);

    NSString *fileName;
    switch (level) {
        case levelOne:
            // Assign image
            fileName = @"DefenseTheTower/defense_level_1.png";
            // Set attack points
            _attackPoints = 1;
            break;
        case levelTwo:
            // Assign image
            fileName = @"DefenseTheTower/defense_level_2.png";
            // Set attack points
            _attackPoints = 2;
            break;
        default:
            break;
    }
    
    // Set defense level
    _defenseLevel = level;
    
    // Initialize sprite with the file name
    _defenseSprite = [[CCSprite alloc] initWithImageNamed:fileName];
    
    // Set defense's anchor point
    self.anchorPoint = CGPointMake(0.5, 0.5);
    _defenseSprite.anchorPoint = CGPointMake(0.5, 0.5);

    // Set content size
    self.contentSize = CGSizeMake(_defenseSprite.contentSize.width, _defenseSprite.contentSize.height);
    
    // Set defense position
    [self setPosition:position];
    
    // Initialize game scene
    _gameScene = scene;
    
    return self;
}

-(void) setPosition:(CGPoint)position {
    _defenseSprite.position = position;
    [super setPosition:position];
}

-(void) update:(CCTime)delta {
    if (_enemyInRange == NULL) {
        for (Enemy *enemy in [_gameScene enemies]) {
            if ([self detectEnemyWithDefenseAtPosition:_defenseSprite.position withRadius:1.5*self.contentSize.width
                                                    andEnemy:enemy.enemySprite.position withRadius:enemy.enemySprite.contentSize.width]) {
                _enemyInRange = enemy;
                
                // Add defense to array of attackers
                [enemy addAttackingDefense:self];
               
                // Attack enemy
                [self schedule:@selector(attackEnemy) interval:0.5f];
                break;
            }
        }
    } else if (![self detectEnemyWithDefenseAtPosition:_defenseSprite.position withRadius:1.5*self.contentSize.width
                                              andEnemy:_enemyInRange.enemySprite.position withRadius:_enemyInRange.enemySprite.contentSize.width]) {
        // Stop shooting
        [self enemyOutOfRange];
    }
}

-(BOOL)detectEnemyWithDefenseAtPosition:(CGPoint)defensePosition withRadius:(float)defenseRadius
                               andEnemy:(CGPoint)enemyPosition withRadius:(float)enemyRadius {
    // Get distance from defense to enemy
    float distanceX = defensePosition.x - enemyPosition.x;
    float distanceY = defensePosition.y - enemyPosition.y;
    float distance = sqrt(distanceX * distanceX + distanceY * distanceY);
    
    // If enemy inside covered area
    if(distance <= defenseRadius + enemyRadius) {
        return YES;
    }
    
    return NO;
}

- (void) attackEnemy {
    if (_enemyInRange != NULL) {
        // Create bullet
        CCSprite *bullet = [CCSprite spriteWithImageNamed:@"DefenseTheTower/bullet.png"];
        bullet.position = CGPointMake(_defenseSprite.position.x, _defenseSprite.position.y);
        
        // Add bullet to the scene
        [[_gameScene batchNode] addChild:bullet z:2];
        
        // Shoot bullet
        CCActionMoveTo *actionMoveBullet = [CCActionMoveTo actionWithDuration:0.2 position:_enemyInRange.enemySprite.position];
        
        // Hurt enemy
        CCActionCallBlock *callHurtEnemy = [CCActionCallBlock actionWithBlock:^{
            _enemyInRange.lifePoints -= _attackPoints;
        }];
        
        // Remove bullet from the scene
        CCActionCallBlock *callRemoveBullet = [CCActionCallBlock actionWithBlock:^{
            [bullet.parent removeChild:bullet cleanup:YES];
        }];
        
        // Execute the whole sequence
        CCActionSequence *sequence = [CCActionSequence actionWithArray:@[actionMoveBullet, callHurtEnemy, callRemoveBullet]];
        [bullet runAction:sequence];
    }
}

- (void) enemyOutOfRange {
    [_enemyInRange outOfRangeFromDefense:self];
    if(_enemyInRange) {
        _enemyInRange = nil;
    }
    [self unschedule:@selector(attackEnemy)];
}

- (void) enemyKilled {
    [_gameScene.enemies removeObject:_enemyInRange];
    [self enemyOutOfRange];
}

@end
