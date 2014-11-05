//
//  PSNetAtmoProfileView.m
//  PhoneAtmo
//
//  Created by Philip Schneider on 03.11.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoProfileView.h"

@implementation PSNetAtmoProfileView

- (id)initWithFrame:(CGRect)frame
{
    DLogFuncName();
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    DLogFuncName();
    UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
    [bezier2Path moveToPoint: CGPointMake(131.14, 109.29)];
    [bezier2Path addCurveToPoint: CGPointMake(120.69, 99.13) controlPoint1: CGPointMake(125.21, 106.69) controlPoint2: CGPointMake(121.69, 103.28)];
    [bezier2Path addCurveToPoint: CGPointMake(125.41, 83.41) controlPoint1: CGPointMake(118.87, 91.61) controlPoint2: CGPointMake(125.42, 83.41)];
    [bezier2Path addLineToPoint: CGPointMake(125.4, 83.41)];
    [bezier2Path addCurveToPoint: CGPointMake(134.14, 41.3) controlPoint1: CGPointMake(125.9, 82.92) controlPoint2: CGPointMake(134.14, 67.06)];
    [bezier2Path addCurveToPoint: CGPointMake(98.43, 0) controlPoint1: CGPointMake(134.14, 21.66) controlPoint2: CGPointMake(126.28, 0)];
    [bezier2Path addCurveToPoint: CGPointMake(62.71, 41.3) controlPoint1: CGPointMake(70.57, 0) controlPoint2: CGPointMake(62.71, 21.66)];
    [bezier2Path addCurveToPoint: CGPointMake(71.24, 83.18) controlPoint1: CGPointMake(62.71, 67.09) controlPoint2: CGPointMake(70.97, 82.94)];
    [bezier2Path addCurveToPoint: CGPointMake(76.17, 99.11) controlPoint1: CGPointMake(71.31, 83.27) controlPoint2: CGPointMake(77.97, 91.57)];
    [bezier2Path addCurveToPoint: CGPointMake(65.71, 109.29) controlPoint1: CGPointMake(75.17, 103.27) controlPoint2: CGPointMake(71.66, 106.69)];
    [bezier2Path addCurveToPoint: CGPointMake(0.43, 138.89) controlPoint1: CGPointMake(25.44, 121.76) controlPoint2: CGPointMake(0.43, 127.62)];
    [bezier2Path addLineToPoint: CGPointMake(0.43, 151.11)];
    [bezier2Path addCurveToPoint: CGPointMake(9.33, 160) controlPoint1: CGPointMake(0.43, 155.56) controlPoint2: CGPointMake(4.88, 160)];
    [bezier2Path addLineToPoint: CGPointMake(187.52, 160)];
    [bezier2Path addCurveToPoint: CGPointMake(196.43, 151.11) controlPoint1: CGPointMake(191.97, 160) controlPoint2: CGPointMake(196.43, 155.56)];
    [bezier2Path addLineToPoint: CGPointMake(196.43, 138.89)];
    [bezier2Path addCurveToPoint: CGPointMake(131.14, 109.29) controlPoint1: CGPointMake(196.43, 127.62) controlPoint2: CGPointMake(171.41, 121.76)];
    [bezier2Path closePath];
    bezier2Path.miterLimit = 4;
    
    [UIColor.blackColor setFill];
    [bezier2Path fill];
}


@end
