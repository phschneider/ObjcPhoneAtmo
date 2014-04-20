//
//  PSNetAtmoDemo.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 07.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmoDemo.h"

@implementation PSNetAtmoDemo

//- (void) changeBackground:(id)sender
//{
//    UIColor * bg = self.view.backgroundColor;
//    NSLog(@"bg = %@",bg);
//    const CGFloat* components = CGColorGetComponents(bg.CGColor);
//    
//    CGFloat value = 0.01;
//    
//    CGFloat red = components[0];
//    CGFloat green = components[1];
//    CGFloat blue = components[2];
//    CGFloat alpha = CGColorGetAlpha(bg.CGColor);
//    
//    if (red < 1 && green < 1 && blue < 1)
//    {
//        red += value;
//    }
//    else if (green < 1 && blue < 1)
//    {
//        green += value;
//    }
//    else if (blue < 1)
//    {
//        blue += value;
//    }
//    else if (alpha < 1)
//    {
//        alpha += value;
//    }
//    else
//    {
//        red = 0.0;
//        green = 0.0;
//        blue = 0.0;
//        alpha = 0.5;
//    }
//    
//    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
//}


//- (void) refresh
//{
//    self.view.backgroundColor = [UIColor randomColorWithAlpha:0.5];
//}

//- (void) random
//{
//    int anz = 4;
//    int space = 0;
//    int x= 10;
//    int y= 0;
//    int w= 200;
//    int screenHeight = ([[[UITabBar alloc] init] respondsToSelector:@selector(barTintColor)]) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] applicationFrame].size.width;
//    int h= arc4random() % screenHeight;
//    NSLog(@"Screenheight = %d",screenHeight);
//    
//    space = (1024-(anz*w)) / (anz+1);
//    
//    x = space;
//    y = screenHeight-h;
//    self.bathRoom.frame = CGRectMake(x, y, w, h);
//    
//    
//    x+= w + space;
//    h = arc4random() % screenHeight;
//    y = screenHeight-h;
//    self.bedRooom.frame = CGRectMake(x, y, w, h);
//    
//    
//    x+= w + space;;
//    h = arc4random() % screenHeight;
//    y = screenHeight-h;
//    
//    self.livingRoom.frame = CGRectMake(x, y, w, h);
//    
//    
//    x+= w + space;;
//    h = arc4random() % screenHeight;
//    y = screenHeight-h;
//    
//    self.balkony.frame = CGRectMake(x, y, w, h);
//}

@end
