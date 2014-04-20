//
//  ToProwlEmptyContactsView.m
//  ToProwl
//
//  Created by Philip Schneider on 02.11.13.
//  Copyright (c) 2013 PhSchneider.net. All rights reserved.
//

#import "PSNetAtmoNoAccountView.h"



@implementation PSNetAtmoNoAccountView

- (id)initWithFrame:(CGRect)frame
{
    DLogFuncName();
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    DLogFuncName();
    ///// Color Declarations
    UIColor* color901repeatselected2xpngColor = [UIColor colorWithRed: 0.667 green: 0.667 blue: 0.667 alpha: 1];
    
    //// Graphic 1051-id-badge@2x.png Drawing
    UIBezierPath* graphic1051idbadge2xpngPath = [UIBezierPath bezierPath];
    [graphic1051idbadge2xpngPath moveToPoint: CGPointMake(166, 106)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(36, 106)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(31, 101.45) controlPoint1: CGPointMake(33.24, 106) controlPoint2: CGPointMake(31, 103.96)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(31, 24.18)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(36, 19.64) controlPoint1: CGPointMake(31, 21.67) controlPoint2: CGPointMake(33.24, 19.64)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(83.5, 19.64)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(86, 21.91) controlPoint1: CGPointMake(84.88, 19.64) controlPoint2: CGPointMake(86, 20.65)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(83.5, 24.18) controlPoint1: CGPointMake(86, 23.16) controlPoint2: CGPointMake(84.88, 24.18)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(36, 24.18)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(36, 101.45)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(166, 101.45)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(166, 24.18)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(118.5, 24.18)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(116, 21.91) controlPoint1: CGPointMake(117.12, 24.18) controlPoint2: CGPointMake(116, 23.16)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(118.5, 19.64) controlPoint1: CGPointMake(116, 20.65) controlPoint2: CGPointMake(117.12, 19.64)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(166, 19.64)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(171, 24.18) controlPoint1: CGPointMake(168.76, 19.64) controlPoint2: CGPointMake(171, 21.67)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(171, 101.45)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(166, 106) controlPoint1: CGPointMake(171, 103.96) controlPoint2: CGPointMake(168.76, 106)];
    [graphic1051idbadge2xpngPath closePath];
    [graphic1051idbadge2xpngPath moveToPoint: CGPointMake(151, 46.91)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(111, 46.91)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(111, 42.36)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(151, 42.36)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(151, 46.91)];
    [graphic1051idbadge2xpngPath closePath];
    [graphic1051idbadge2xpngPath moveToPoint: CGPointMake(108.5, 33.27)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(93.5, 33.27)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(91, 31) controlPoint1: CGPointMake(92.12, 33.27) controlPoint2: CGPointMake(91, 32.26)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(91, 24.18)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(91, 19.64)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(91, 8.27)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(93.5, 6) controlPoint1: CGPointMake(91, 7.02) controlPoint2: CGPointMake(92.12, 6)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(108.5, 6)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(111, 8.27) controlPoint1: CGPointMake(109.88, 6) controlPoint2: CGPointMake(111, 7.02)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(111, 19.64)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(111, 24.18)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(111, 31)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(108.5, 33.27) controlPoint1: CGPointMake(111, 32.26) controlPoint2: CGPointMake(109.88, 33.27)];
    [graphic1051idbadge2xpngPath closePath];
    [graphic1051idbadge2xpngPath moveToPoint: CGPointMake(106, 10.55)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(96, 10.55)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(96, 19.64)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(106, 19.64)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(106, 10.55)];
    [graphic1051idbadge2xpngPath closePath];
    [graphic1051idbadge2xpngPath moveToPoint: CGPointMake(106, 24.18)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(96, 24.18)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(96, 28.73)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(106, 28.73)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(106, 24.18)];
    [graphic1051idbadge2xpngPath closePath];
    [graphic1051idbadge2xpngPath moveToPoint: CGPointMake(111, 51.45)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(151, 51.45)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(151, 56)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(111, 56)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(111, 51.45)];
    [graphic1051idbadge2xpngPath closePath];
    [graphic1051idbadge2xpngPath moveToPoint: CGPointMake(111, 60.55)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(151, 60.55)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(151, 65.09)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(111, 65.09)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(111, 60.55)];
    [graphic1051idbadge2xpngPath closePath];
    [graphic1051idbadge2xpngPath moveToPoint: CGPointMake(151, 83.27)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(121, 83.27)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(121, 78.73)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(151, 78.73)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(151, 83.27)];
    [graphic1051idbadge2xpngPath closePath];
    [graphic1051idbadge2xpngPath moveToPoint: CGPointMake(116, 69.64)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(151, 69.64)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(151, 74.18)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(116, 74.18)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(116, 69.64)];
    [graphic1051idbadge2xpngPath closePath];
    [graphic1051idbadge2xpngPath moveToPoint: CGPointMake(68.5, 52.59)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(81, 37.82) controlPoint1: CGPointMake(68.5, 44.43) controlPoint2: CGPointMake(74.1, 37.82)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(93.5, 52.59) controlPoint1: CGPointMake(87.9, 37.82) controlPoint2: CGPointMake(93.5, 44.43)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(86.28, 65.48) controlPoint1: CGPointMake(93.5, 59.09) controlPoint2: CGPointMake(89.83, 63.28)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(111, 85.55) controlPoint1: CGPointMake(89.01, 77.43) controlPoint2: CGPointMake(111, 68.49)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(108.5, 87.82) controlPoint1: CGPointMake(111, 86.8) controlPoint2: CGPointMake(109.88, 87.82)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(81, 87.82)];
    [graphic1051idbadge2xpngPath addLineToPoint: CGPointMake(53.5, 87.82)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(51, 85.55) controlPoint1: CGPointMake(52.12, 87.82) controlPoint2: CGPointMake(51, 86.8)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(75.72, 65.48) controlPoint1: CGPointMake(51, 68.49) controlPoint2: CGPointMake(72.99, 77.43)];
    [graphic1051idbadge2xpngPath addCurveToPoint: CGPointMake(68.5, 52.59) controlPoint1: CGPointMake(72.17, 63.28) controlPoint2: CGPointMake(68.5, 59.09)];
    [graphic1051idbadge2xpngPath closePath];
    [color901repeatselected2xpngColor setFill];
    [graphic1051idbadge2xpngPath fill];
    
    

}


@end
