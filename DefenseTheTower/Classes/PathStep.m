#import "PathStep.h"

@implementation PathStep

- (PathStep *) initWithPosition:(CGPoint)position {
    self = [super init];
    if (!self) return(nil);
    
    // Initialize sprite
    _pathStepSprite = [[CCSprite alloc] initWithImageNamed:@"DefenseTheTower/path_step.png"];
    
    // Set path step's anchor point
    self.anchorPoint = CGPointMake(0.5, 0.5);
    _pathStepSprite.anchorPoint = CGPointMake(0.5, 0.5);
    
    //Set path step position
    [self setPosition:position];
    
    return self;
}

- (void) setPosition:(CGPoint)position {
    _pathStepSprite.position = position;
    [super setPosition:position];
}

@end
