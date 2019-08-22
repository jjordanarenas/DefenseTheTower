#import "GameScene.h"
#import "PathStep.h"

// Number of path steps
#define NUM_PATH_STEPS 10
// Number of defenses
#define NUM_DEFENSES 30
// Number of enemies
#define NUM_ENEMIES 10
// Base number of enemies for each wave
#define WAVES_NUM_ENEMIES 10
// Number of waves
#define NUM_WAVES 10
// Waves interval
#define WAVES_INTERVAL 24

@implementation GameScene {
    // Declare global variable for screen size
    CGSize _screenSize;
    
    // Declare array of path steps
    NSMutableArray *_pathSteps;
    
    // Declare variable to keep square size
    float _squareSize;

    // Declare array of defense positions
    NSMutableArray *_defensePositions;
    
    // Declare array of defenses
    NSMutableArray *_defenses;
    
    // Declare number of wave
    int _waveNumber;
    // Label to show the wave
    CCLabelTTF *_waveLabel;
    // Declare count of enemies
    int _countEnemies;
    
    // Declare life points
    int _lifePoints;
    // Label to show the life points
    CCLabelTTF *_lifePointsLabel;
}

+ (GameScene *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Initialize screen size variable
    _screenSize = [CCDirector sharedDirector].viewSize;
    
    // Load texture atlas
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"defensethetower-hd.plist"];
    
    // Load batch node with texture atlas
    _batchNode = [CCSpriteBatchNode batchNodeWithFile:@"defensethetower-hd.png"];
    
    // Add the batch node to the scene
    [self addChild:_batchNode];
    
    // Create the background
    CCSprite *background = [CCSprite spriteWithImageNamed:@"DefenseTheTower/background.png"];
    background.position = CGPointMake(_screenSize.width / 2, _screenSize.height / 2);
    [_batchNode addChild:background z:-1];
    
    // Initialize square size
    _squareSize = _screenSize.height / 8;
    
    // Load path steps
    [self loadPathSteps];

    // Load defense positions
    [self loadDefensePositions];

    // Initialize array of defenses
    _defenses = [[NSMutableArray alloc] initWithCapacity:NUM_DEFENSES];
    
    // Enable touches management
    self.userInteractionEnabled = TRUE;

    // Initialize wave number
    _waveNumber = 1;
    
    // Initialize and place wave label
    _waveLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Wave %i", _waveNumber + 1] fontName:@"Arial" fontSize:15];
    _waveLabel.position = CGPointMake(40 , _screenSize.height - 25);
    _waveLabel.anchorPoint = CGPointMake(0.5, 0.5);
    _waveLabel.color = [CCColor blackColor];
    // Add score label to scene
    [self addChild:_waveLabel];

    // Schedule waves
    [self schedule:@selector(loadWave) interval:WAVES_INTERVAL repeat:NUM_WAVES delay:0.0];
    
    // Add tower
    CCSprite *tower = [CCSprite spriteWithImageNamed:@"DefenseTheTower/tower.png"];
    tower.position = ((CCSprite *)[_pathSteps objectAtIndex:0]).position;
    [_batchNode addChild:tower z:2];

    // Initialize life points
    _lifePoints = 10;
    _lifePointsLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Life: %i", _lifePoints] fontName:@"Arial" fontSize:15];
    _lifePointsLabel.position = CGPointMake(_screenSize.width - 50 , 20);
    _lifePointsLabel.anchorPoint = CGPointMake(0.5, 0.5);
    _lifePointsLabel.color = [CCColor blackColor];
    // Add score label to scene
    [self addChild:_lifePointsLabel];

    return self;
}

-(void)loadPathSteps {
    // Initialize array of path steps
    _pathSteps = [[NSMutableArray alloc] initWithCapacity:NUM_PATH_STEPS];
    
    // Create path step
    PathStep *pathStep9 = [[PathStep alloc] initWithPosition:CGPointMake(_screenSize.width - _squareSize * 1.2, _screenSize.height - _squareSize * 2)];
    [_pathSteps addObject:pathStep9];
    [_batchNode addChild:pathStep9.pathStepSprite];
    
    // Create path step
    PathStep *pathStep8 = [[PathStep alloc] initWithPosition:CGPointMake(_squareSize * 10.5, _screenSize.height - _squareSize * 2)];
    [_pathSteps addObject:pathStep8];
    [_batchNode addChild:pathStep8.pathStepSprite];
    pathStep8.nextPathStep = pathStep9;
    
    // Create path step
    PathStep *pathStep7 = [[PathStep alloc] initWithPosition:CGPointMake(_squareSize * 10.5, _squareSize * 3.5)];
    [_pathSteps addObject:pathStep7];
    [_batchNode addChild:pathStep7.pathStepSprite];
    pathStep7.nextPathStep = pathStep8;

    // Create path step
    PathStep *pathStep6 = [[PathStep alloc] initWithPosition:CGPointMake(_squareSize * 7.8, _squareSize * 3.5)];
    [_pathSteps addObject:pathStep6];
    [_batchNode addChild:pathStep6.pathStepSprite];
    pathStep6.nextPathStep = pathStep7;
    
    // Create path step
    PathStep *pathStep5 = [[PathStep alloc] initWithPosition:CGPointMake(_squareSize * 7.8, _screenSize.height - _squareSize * 2)];
    [_pathSteps addObject:pathStep5];
    [_batchNode addChild:pathStep5.pathStepSprite];
    pathStep5.nextPathStep = pathStep6;
    
    // Create path step
    PathStep *pathStep4 = [[PathStep alloc] initWithPosition:CGPointMake(_squareSize * 5.2, _screenSize.height - _squareSize * 2)];
    [_pathSteps addObject:pathStep4];
    [_batchNode addChild:pathStep4.pathStepSprite];
    pathStep4.nextPathStep = pathStep5;
    
    // Create path step
    PathStep *pathStep3 = [[PathStep alloc] initWithPosition:CGPointMake(_squareSize * 5.2, _squareSize * 2)];
    [_pathSteps addObject:pathStep3];
    [_batchNode addChild:pathStep3.pathStepSprite];
    pathStep3.nextPathStep = pathStep4;
    
    // Create path step
    PathStep *pathStep2 = [[PathStep alloc] initWithPosition:CGPointMake(_squareSize * 2.5, _squareSize * 2)];
    [_pathSteps addObject:pathStep2];
    [_batchNode addChild:pathStep2.pathStepSprite];
    pathStep2.nextPathStep = pathStep3;
    
    // Create path step
    PathStep *pathStep1 = [[PathStep alloc] initWithPosition:CGPointMake(_squareSize * 2.5, _screenSize.height - _squareSize * 3.30)];
    [_pathSteps addObject:pathStep1];
    [_batchNode addChild:pathStep1.pathStepSprite];
    pathStep1.nextPathStep = pathStep2;
    
    // Create path step
    PathStep *pathStep0 = [[PathStep alloc] initWithPosition:CGPointMake(-50, _screenSize.height - _squareSize * 3.30)];
    [_pathSteps addObject:pathStep0];
    [_batchNode addChild:pathStep0.pathStepSprite];
    pathStep0.nextPathStep = pathStep1;
    
    // Hide path steps
    pathStep0.pathStepSprite.visible = FALSE;
    pathStep1.pathStepSprite.visible = FALSE;
    pathStep2.pathStepSprite.visible = FALSE;
    pathStep3.pathStepSprite.visible = FALSE;
    pathStep4.pathStepSprite.visible = FALSE;
    pathStep5.pathStepSprite.visible = FALSE;
    pathStep6.pathStepSprite.visible = FALSE;
    pathStep7.pathStepSprite.visible = FALSE;
    pathStep8.pathStepSprite.visible = FALSE;
    pathStep9.pathStepSprite.visible = FALSE;
    
}

- (void)loadEnemy {
    if (_countEnemies < WAVES_NUM_ENEMIES) {
        // Initialize enemy
        Enemy *enemy = [[Enemy alloc] initEnemyWithPathStep:[_pathSteps objectAtIndex:_pathSteps.count - 1] andScene:self];
        // Add enemy to the array
        [_enemies addObject:enemy];
    
        // Add the enemy to the scene
        [_batchNode addChild:enemy];
        [_batchNode addChild:enemy.enemySprite];
        
        _countEnemies++;
    } else {
        [self unschedule:@selector(loadEnemy)];
    }
}

-(void)loadDefensePositions {
    // Retrieve plist
    NSString *defensesPlist = [[NSBundle mainBundle] pathForResource:@"DefensePositions" ofType:@"plist"];
    // Retrieve array of positions
    NSArray *defensePositions = [NSArray arrayWithContentsOfFile:defensesPlist];
    
    // Initialize array of defense positions
    _defensePositions = [[NSMutableArray alloc] initWithCapacity:NUM_DEFENSES];
    
    // Declare defense position sprite
    CCSprite *defensePositionSprite;
    // Declare auxiliar sprite
    CCSprite *defenseAux = [CCSprite spriteWithImageNamed:@"DefenseTheTower/defense_level_1.png"];
    
    // Declare auxiliar floats
    float gap = 19;
    float spriteWidth = defenseAux.contentSize.width;
    float multiplierX, multiplierY;
    
    for(NSDictionary *defensePosition in defensePositions) {
        // Initialize defense position sprite
        defensePositionSprite = [CCSprite spriteWithImageNamed:@"DefenseTheTower/defense_position.png"];
        
        // Retrieve x and y position multipliers
        multiplierX = [[defensePosition objectForKey:@"x"] floatValue];
        multiplierY = [[defensePosition objectForKey:@"y"] floatValue];
        
        // Set position
        [defensePositionSprite setPosition:CGPointMake(spriteWidth * multiplierX + gap, spriteWidth * multiplierY)];
        // Add position to array of defense positions
        [_defensePositions addObject:defensePositionSprite];
        
        // Add defense position to scene
        [_batchNode addChild:defensePositionSprite];
    }
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // Get touch position
    CGPoint touchLocation = [touch locationInNode:self];
    
    // Iterate defense positions
    for (CCSprite *defensePosition in _defensePositions) {
        if (CGRectContainsPoint(defensePosition.boundingBox, touchLocation)) {
            // Initialize defense
            Defense *defense = [[Defense alloc] initDefenseWithLevel:(DefenseLevel)levelOne scene:self andPosition:defensePosition.position];
            [_defenses addObject:defense];
            // Add defense to the scene
            [_batchNode addChild:defense.defenseSprite z:1];
            
            // Add defense for update availability
            [_batchNode addChild:defense];
        }
    }
}

- (void) loadWave {
    // Initialize count and array of enemies
    _countEnemies = 0;
    _enemies = [[NSMutableArray alloc] initWithCapacity:WAVES_NUM_ENEMIES];
    
    // Update label
    [_waveLabel setString:[NSString stringWithFormat:@"Wave %i", _waveNumber]];
    
    // Load enemies
    [self schedule:@selector(loadEnemy) interval:1.0];
    
    // Increase wave number
    _waveNumber++;
}

- (void)enemyReachedTower {
    _lifePoints--;
    // Update label
    [_lifePointsLabel setString:[NSString stringWithFormat:@"Life: %i", _lifePoints]];
}

@end
