#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PathStep : CCNode {
    
}

// Property for the next step
@property (nonatomic, assign) PathStep *nextPathStep;
// Property for the sprite
@property (readwrite, nonatomic) CCSprite *pathStepSprite;

// Init method
- (PathStep *) initWithPosition:(CGPoint)position;

@end
