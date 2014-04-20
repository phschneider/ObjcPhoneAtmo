//
//  PSNetAtmoModuleView.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmoModule.h"
#import "PSNetAtmoModule+Helper.h"
#import "PSNetAtmoModuleView.h"
#import "UIColor+Random.h"

@interface PSNetAtmoModuleView()

@property (nonatomic, strong)  UILabel * nameLabel;
@property (nonatomic, strong)  UILabel * temparatureLabel;
@property (nonatomic, strong)  UILabel * humidityLabel;
@property (nonatomic) UIView * borderView;

@property (nonatomic) CGRect unfoldedFrame;
@property (nonatomic) CGRect foldedFrame;
@end

#define WIDTH   5

@implementation PSNetAtmoModuleView

- (id) initWithFrame:(CGRect)frame
{
    DLogFuncName();

    CGRect helperFrame = frame;
    helperFrame.origin.x += frame.size.width;
    helperFrame.size.width = WIDTH;
    
    self = [super initWithFrame:helperFrame];
    if (self)
    {
        self.unfoldedFrame = frame;
        self.foldedFrame = helperFrame;
        
        int width = WIDTH;
        helperFrame.origin.x = 0;
//        frame.origin.x = frame.size.width - width;
//        frame.size.width = width;
        
        self.borderView = [[UIView alloc] initWithFrame:helperFrame];
        self.borderView.backgroundColor = [UIColor whiteColor];
        self.borderView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:self.borderView];
        
        
        self.nameLabel = [self defaultLabelWithText:@""];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:22];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.nameLabel];
        
        self.temparatureLabel = [self defaultLabelWithText:@""];
        self.temparatureLabel.font = [UIFont boldSystemFontOfSize:100];
        self.temparatureLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.temparatureLabel];
        
        self.humidityLabel = [self defaultLabelWithText:@""];
        self.humidityLabel.font = [UIFont boldSystemFontOfSize:40];
        self.humidityLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.humidityLabel];
        
        [self bringSubviewToFront:self.nameLabel];
        [self bringSubviewToFront:self.temparatureLabel];
    }
    return self;
}


- (id)initWithModule:(PSNetAtmoModule *)module andFrame:(CGRect)frame
{
    DLogFuncName();
    self = [self initWithFrame:frame];
    if (self)
    {
        self.nameLabel.text = module.name;
    }
    return self;
}

- (id)initWithModule:(PSNetAtmoModule *)module
{
    DLogFuncName();
    self = [super init];
    if (self)
    {
        
    }
    return self;
}


- (void) unfold
{
    DLogFuncName();
    [self unfoldAnimated:YES];
}


- (void) unfoldAnimated:(BOOL)animated
{
    DLogFuncName();
    
    [UIView animateWithDuration:(animated) ? 2.5 : 0.0
                        delay:1.0
                      options: UIViewAnimationCurveLinear
                   animations:^{
                       self.frame = self.unfoldedFrame;
                   }
                   completion:^(BOOL finished){
                       NSLog(@"Done!");
                   }];

}


- (UILabel*)defaultLabelWithText:(NSString*)text
{
    DLogFuncName();
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.shadowColor = [UIColor darkGrayColor];
    label.shadowOffset = CGSizeMake(-2,-2);
    label.backgroundColor = [UIColor randomColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}


- (void) setValuesFromDict:(NSDictionary*)dict
{
    DLogFuncName();
    self.temparatureLabel.text = [NSString stringWithFormat:@" %.f°",[[dict objectForKey:@"a"] floatValue]];
    self.humidityLabel.text = [NSString stringWithFormat:@" %.f%@",[[dict objectForKey:@"b"] floatValue],@"%"];
   
    int max = 40;
    int min = 0;
    float val =[[dict objectForKey:@"a"] floatValue];
//    if (val > 20)
//    {
//        val = -5;
//    }
    
#warning todo  darstellung von nergativ werten
    int screenHeight = ([[[UITabBar alloc] init] respondsToSelector:@selector(barTintColor)]) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] applicationFrame].size.width;
    NSLog(@"screenHeight = %d",screenHeight);
    int height = ceil(ceil(screenHeight/ABS(max+min))*ceil(val));
    CGRect frame = self.frame;
    frame.size.height = height;
    frame.origin.y = screenHeight-height;
    self.frame = frame;
    // CO2
//    self.humidityLabel.text = [NSString stringWithFormat:@" %.f%@",[[dict objectForKey:@"h"] floatValue],@"%"];
}


- (void) layoutSubviews
{
    DLogFuncName();
    [super layoutSubviews];
//    int w = self.frame.size.width;
//    int h = 50;
//    NSLog(@"\n\n\n\n\n%@ = %@",self.nameLabel.text, NSStringFromCGRect(self.frame));
//
//    int screenHeight = ([[[UITabBar alloc] init] respondsToSelector:@selector(barTintColor)]) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] applicationFrame].size.width;
//    NSLog(@"screenHeight = %d",screenHeight);
//    
//    CGRect rect = self.nameLabel.frame;
//    if(rect.origin.y < 0)
//    {
//        rect.origin.y = 0;
//    }
//    
//    rect.size.width = w;
//    rect.size.height = 50;
//    rect.origin.y = self.frame.size.height - rect.size.height;
//    self.nameLabel.frame = rect;
//    NSLog(@"nameLabel = %@",NSStringFromCGRect(rect));
//    
//    
//    rect = self.humidityLabel.frame;
//    rect.origin.y = ceil((self.frame.size.height - h)/2);
//    if(rect.origin.y < 0)
//    {
//        rect.origin.y = 0;
//    }
//    rect.size.width = w;
//    rect.size.height = 50;
//    self.humidityLabel.frame = rect;
//    NSLog(@"humidityLabel = %@",NSStringFromCGRect(rect));
//    
//    
//    h = 100;
//    rect = self.temparatureLabel.frame;
//    rect.size.width = w;
//    rect.size.height = h;
//    rect.origin.y = 0 - h;
//    
//    if ((self.frame.size.height + h) >= screenHeight - 20)
//    {
//        rect.origin.y = 0 - (screenHeight - 20 - self.frame.size.height);
//    }
//    self.temparatureLabel.frame = rect;
//    NSLog(@"temparatureLabel = %@",NSStringFromCGRect(rect));
}

@end
