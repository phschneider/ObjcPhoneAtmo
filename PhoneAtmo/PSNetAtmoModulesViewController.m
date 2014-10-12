//
// Created by pschneider on 23.11.13.
//
// Copyright (c) 2013 Haus & Gross communications. All rights reserved.
//


#import "PSNetAtmo.h"
#import "PSNetAtmoModuleView.h"
#import "PSNetAtmoModulesViewController.h"
#import "UIColor+Random.h"


@interface PSNetAtmoModulesViewController()

@property (nonatomic) PSNetAtmoDevice * device;
@property (nonatomic) NSTimer *updateTimer;
@property (nonatomic) NSMutableArray * moduleViewArray;
@end

@implementation PSNetAtmoModulesViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}


- (id)initWithDevice:(PSNetAtmoDevice *)device
{
    DLogFuncName();
    self = [self init];
    if (self)
    {
//        self.title = device.deviceName;
        self.device = device;
        self.view.backgroundColor = [UIColor randomColorWithAlpha:0.5];

        UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizerFired:)];
        [self.view addGestureRecognizer:tapRecognizer];
        
     //    [PSNetAtmoApi publicMeassures];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valuesUpdated:) name:PSNETATMO_DEVICE_UPDATE_NOTIFICATION object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userUpdated:) name:PSNETATMO_USER_UPDATE_NOTIFICATION object:nil];
#warning TODO - Spinning Wheel bis alle Werte vorliegen
    }
    return self;
}


- (void) viewDidLoad
{
    DLogFuncName();
}


- (void) viewWillAppear:(BOOL)animated
{
    DLogFuncName();
    [super viewWillAppear:animated];
}


- (void) viewDidAppear:(BOOL)animated
{
    DLogFuncName();
    [super viewDidAppear:animated];
    
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval: 60.0*2
                                                        target: self
                                                      selector:@selector(updateTimerFired)
                                                      userInfo: nil
                                                       repeats:YES];
    
    [self performSelector:@selector(addModuleViews) withObject:nil afterDelay:.25];
}


#pragma mark - Timer
- (void) updateTimerFired
{
    DLogFuncName();
}


#pragma mark - TagRecognizer
- (void) tapRecognizerFired:(UITapGestureRecognizer*)recognizer
{
    DLogFuncName();
}


#pragma mark - Notification
- (void) userUpdated:(NSNotification*) note
{
    DLogFuncName();
    //    [PSNetAtmoUser sharedInstance];
    [self valuesUpdated:nil];
}


- (void) valuesUpdated:(id)sender
{
    DLogFuncName();

}


#pragma mark - ModuleViews
- (void) addModuleViews
{
    DLogFuncName();
    [self addModuleViewsAnimated:YES];
}


- (void) addModuleViewsAnimated:(BOOL)animated
{
    DLogFuncName();
    int modulesCount = [self.device.modules count];
    CGRect frame = CGRectMake(0, 80, 1024, 768 - 80);
    frame.size.width = (1024 / (modulesCount +2));
    frame.origin.x = ceil(frame.size.width/2);
    self.moduleViewArray = [[NSMutableArray alloc] initWithCapacity:modulesCount];

#warning TODO - höhe anhand aktueller Temperatur
    for (PSNetAtmoModule* module in self.device.modules)
    {
        NSLog(@"--- Frame = %@", NSStringFromCGRect(frame));
       
        PSNetAtmoModuleView * moduleView = [[PSNetAtmoModuleView alloc] initWithModule:module andFrame:frame];
        moduleView.tag = [module tag];
        moduleView.backgroundColor = [UIColor randomColor];
        
        if (animated)
        {
            moduleView.frame = CGRectOffset( moduleView.frame, 0, 768 );
        }
        
        [self.view addSubview:moduleView];
        
        
        frame.origin.x += frame.size.width + ceil(frame.size.width/2);
        
        [self.moduleViewArray addObject:moduleView];
       
    }
    
    
    
    if (animated)
    {
        [self elevateViews];
    }
}

- (void) elevateViews
{
    DLogFuncName();
    
    NSTimeInterval delay = .5;
    for (PSNetAtmoModuleView * moduleView in self.moduleViewArray)
    {
        [self performSelector:@selector(animateElevateionForView:) withObject:moduleView afterDelay:delay];
        delay += 1.0;
    }
}

- (void) animateElevateionForView:(UIView*)view
{
    DLogFuncName();
    [UIView animateWithDuration:2.5
                          delay:1.0
                        options: UIViewAnimationCurveLinear
                     animations:^{
                         view.frame = CGRectOffset( view.frame, 0, -768 );
                     }
                     completion:^(BOOL finished){
                         if (finished && [self.moduleViewArray lastObject] == view)
                         {
                             [self unfoldViews];
                         }
                         NSLog(@"Done! %d", view.tag);
                     }];
    
}

- (void) unfoldViews
{
    DLogFuncName();
    [self unfoldViewsAnimated:YES];
}


- (void) unfoldViewsAnimated:(BOOL)animated
{
    DLogFuncName();
    NSTimeInterval delay = .5;
    for (PSNetAtmoModuleView * moduleView in self.moduleViewArray)
    {
        if (animated)
        {
            [moduleView performSelector:@selector(unfold) withObject:nil afterDelay:delay];
            delay += 1.0;
        }
        else
        {
            [moduleView unfoldAnimated:NO];
        }
    }
}



@end