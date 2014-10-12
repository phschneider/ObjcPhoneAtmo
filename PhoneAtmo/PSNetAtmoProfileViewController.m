//
//  PSNetAtmoProfileViewController.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 26.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSAppDelegate.h"
#import "PSNetAtmoUser+Helper.h"
#import "PSNetAtmoProfileViewController.h"

@interface PSNetAtmoProfileViewController ()

@property(nonatomic) UIView *loggedInView;
@property (nonatomic) UILabel *mailLabel;
@property (nonatomic) UIImageView *flagView;
@property (nonatomic) UIButton *logoutButton;
@property (nonatomic) UILabel *accountValidDateLabel;

@property(nonatomic) UIView *loggedOutView;
@property(nonatomic) UIButton *loginButton;
@property(nonatomic) UIButton *onePasswordButton;
@property(nonatomic, strong) UITextField *userTextField;
@property(nonatomic, strong) UITextField *passwordTextField;
@property(nonatomic) UIBarButtonItem *signInItem;
@end

@implementation PSNetAtmoProfileViewController

- (id) init
{
    DLogFuncName();
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];

//        self.loggedInView = [self initLoggedInView];
//        self.loggedOutView = [self initLoggedOutView];

        self.title = @"Profile";
    }
    return self;
}


//- (UIView *) initLoggedInView
//{
//    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
//    view.backgroundColor = [UIColor lightGrayColor];
//    return view;
//}
//
//
//- (UIView *) initLoggedOutView
//{
//    DLogFuncName();
//
//    UView *view = [[UIView alloc] initWithFrame:self.view.bounds];
//    self.loggedOutView.backgroundColor = [UIColor grayColor];
//
//    CGRect textFieldFrame = CGRectMake(20, 200, self.view.frame.size.width - 40, 50);
//    self.userTextField = [[UITextField alloc] initWithFrame:textFieldFrame];
//    self.userTextField.borderStyle = UITextBorderStyleLine;
//    self.userTextField.delegate = self;
//    self.userTextField.placeholder = @"username";
//    [self.loggedOutView addSubview:self.userTextField];
//
//    textFieldFrame.origin.y += textFieldFrame.size.height + 20;
//    self.passwordTextField = [[UITextField alloc] initWithFrame:textFieldFrame];
//    self.passwordTextField.delegate = self;
//    self.passwordTextField.borderStyle = UITextBorderStyleLine;
//    self.passwordTextField.secureTextEntry = YES;
//    self.passwordTextField.placeholder = @"password";
//    [self.loggedOutView addSubview:self.passwordTextField];
//
//
//    CGRect buttonFrame = CGRectMake(50, self.passwordTextField.frame.origin.y + self.passwordTextField.frame.size.height + 20 , self.view.frame.size.width - 2*50,50);
//    self.loginButton = [[UIButton alloc] initWithFrame:buttonFrame];
//    self.loginButton.center = self.view.center;
//    [self.loggedOutView addSubview:self.loginButton];
//
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"onepassword://search"]])
//        {
//            NSLog(@"1Password is installed!");
//
//            UIView *onePasswordLogoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonFrame.size.width, buttonFrame.size.height)];
//            onePasswordLogoView.backgroundColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.81 alpha:1];
//            onePasswordLogoView.layer.cornerRadius = 20;
//
//            self.onePasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            self.onePasswordButton.frame = buttonFrame;
//            [self.onePasswordButton addTarget:self action:@selector(onePasswordButtonTouched) forControlEvents:UIControlEventAllTouchEvents];
//            [self.onePasswordButton setTitle:@"Launch 1Password" forState:UIControlStateNormal];
//
//            [self.onePasswordButton addSubview:onePasswordLogoView];
//            [self.loggedOutView addSubview:self.onePasswordButton];
//        }
//}


- (void) viewDidAppear:(BOOL)animated
{
    DLogFuncName();

    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView transitionFromView:self.loggedInView
                            toView:self.loggedOutView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        completion:^(BOOL finished){
                            /* do something on animation completion */
                            NSLog(@"Complete...");
                        }];

    });
   }

- (void)signInItemTouched
{
    DLogFuncName();
}


- (void)onePasswordButtonTouched
{
    DLogFuncName();
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"onepassword://search/netatmo"]];
}


- (void)logoutButtonTouched
{
    DLogFuncName();
    [PSNetAtmoUser resetCurrentUserInContext:APPDELEGATE.managedObjectContext];
}

@end
