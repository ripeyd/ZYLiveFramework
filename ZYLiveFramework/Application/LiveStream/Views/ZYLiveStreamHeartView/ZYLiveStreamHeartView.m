//
//  ZYLiveStreamHeartView.m
//  PIXY
//
//  Created by gao feng on 16/5/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ZYLiveStreamHeartView.h"
#import "SharedMacro.h"
#import "UIBezierPath+Interpolation.h"
#import "ZYLiveStreamLikeChannelMessage.h"

@interface ZYLiveStreamHeartView ()
@property (nonatomic, strong) UIImage                                               *imgHeart;
@property (nonatomic, assign) KCLiveStreamLikeChannelMessageColorType   curHeartType;

@end

@implementation ZYLiveStreamHeartView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _curHeartType = [ZYLiveStreamLikeChannelMessage getRandomHeartColor];
    }
    return self;
}

- (void)fireHeart:(NSNumber*)colorId {
    
    self.imgHeart = [ZYLiveStreamLikeChannelMessage getHeartImageByType:colorId.intValue];
    
    CGPoint birthPos = CGPointMake(SCREEN_WIDTH - 72 - 12, SCREEN_HEIGHT - 80);
    float dur = 3.0f;
    
    //create heart
    UIImage* heartImg = self.imgHeart;
    CALayer *movingLayer = [CALayer layer];
    movingLayer.contents = (id)heartImg.CGImage;
    movingLayer.anchorPoint = CGPointZero;
    movingLayer.frame = CGRectMake(birthPos.x, birthPos.y, 27, 27);
    [self.layer addSublayer:movingLayer];
    
    //create bezier path
    NSArray* points = [self getCurvePathPoints:birthPos];
    UIBezierPath* curve = [UIBezierPath interpolateCGPointsWithHermite:points closed:false];
    
    //move it
    CAKeyframeAnimation* pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = dur;
    pathAnimation.path = curve.CGPath;
    pathAnimation.calculationMode = kCAAnimationLinear;
    pathAnimation.delegate = self;
    [pathAnimation setValue:movingLayer forKey:@"animationLayer"];
    pathAnimation.removedOnCompletion = true;
    [movingLayer addAnimation:pathAnimation forKey:@"movingAnimation"];
    

    CAKeyframeAnimation* fadeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.beginTime = CACurrentMediaTime() + 1.0;
    fadeAnimation.duration = dur-1.0f;
    fadeAnimation.keyTimes = @[@0.0, @0.25, @0.75, @1.0];
    fadeAnimation.values = @[@1.0, @0.8, @0.5, @0];
    fadeAnimation.removedOnCompletion = false;
    fadeAnimation.fillMode = kCAFillModeForwards;
    [movingLayer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
}

- (NSArray*)getCurvePathPoints:(CGPoint)basePos
{
    NSMutableArray* points = @[].mutableCopy;
    [points addObject:[NSValue valueWithCGPoint:basePos]];
    
    int dir = 1; //1 for left, -1 for right
    if (arc4random()%2 == 0) {
        dir = -1;
    }
    
    int movedY = 0;
    int step = 100;
    int stepOffset = arc4random()%10 + 20;
    for (int i = 0; i < 4; i ++) {
        int offsetX = 5 + arc4random()%10;
        offsetX *= dir;
        dir *= -1;
        
        int offsetY = movedY+step;
        movedY = offsetY;
        step -= stepOffset;
        
        [points addObject:[NSValue valueWithCGPoint:CGPointMake(basePos.x+offsetX, basePos.y-offsetY)]];
    }
    
    return points;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        CALayer *layer = [anim valueForKey:@"animationLayer"];
        if (layer) {
            [layer removeFromSuperlayer];
        }

    }
}

- (UIImage*)getRandomHeart
{
    int LikeChannelMessageColorType = [ZYLiveStreamLikeChannelMessage getRandomHeartColor];
    return [ZYLiveStreamLikeChannelMessage getHeartImageByType:LikeChannelMessageColorType];
}

- (NSNumber*)getCurrentGuestColorId {
    return @(_curHeartType);
}




@end
