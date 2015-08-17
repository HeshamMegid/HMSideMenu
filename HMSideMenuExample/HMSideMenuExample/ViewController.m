//
//  ViewController.m
//  HMSideMenu
//
//  Created by Hesham Abd-Elmegid on 4/24/13.
//  Copyright (c) 2013 Hesham Abd-Elmegid. All rights reserved.
//

#import "ViewController.h"
//#import "UIView+DTActionHandlers.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *twitterItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterItem setMenuActionWithBlock:^{
        NSLog(@"tapped twitter item");
    }];
    UIImageView *twitterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterIcon setImage:[UIImage imageNamed:@"twitter"]];
    [twitterItem addSubview:twitterIcon];
    
    UIView *emailItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emailItem setMenuActionWithBlock:^{
        NSLog(@"tapped email item");
    }];
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30 , 30)];
    [emailIcon setImage:[UIImage imageNamed:@"email"]];
    [emailItem addSubview:emailIcon];
    
    UIView *facebookItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [facebookItem setMenuActionWithBlock:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"Tapped facebook item"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil, nil];
        [alertView show];

    }];    
    UIImageView *facebookIcon = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 35, 35)];
    [facebookIcon setImage:[UIImage imageNamed:@"facebook"]];
    [facebookItem addSubview:facebookIcon];
    
    UIView *browserItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserItem setMenuActionWithBlock:^{
        NSLog(@"tapped browser item");
    }];    
    UIImageView *browserIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserIcon setImage:[UIImage imageNamed:@"browser"]];
    [browserItem addSubview:browserIcon];

    self.sideMenu = [[HMSideMenu alloc] initWithItems:@[twitterItem, emailItem, facebookItem, browserItem]];
    [self.sideMenu setItemSpacing:5.0f];
    [self.view addSubview:self.sideMenu];

    UIScreenEdgePanGestureRecognizer *rightEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightEdgeGesture:)];
    rightEdgeGesture.edges = UIRectEdgeRight;
    rightEdgeGesture.delegate = self;
    rightEdgeGesture.maximumNumberOfTouches=1;
    [self.view addGestureRecognizer:rightEdgeGesture];
    
    // Store the center, so we can animate back to it after a slide
    _centerX = self.view.bounds.size.width / 2;
}

- (IBAction)toggleMenu:(id)sender {
    if (self.sideMenu.isOpen)
        [self.sideMenu close];
    else
        [self.sideMenu open];
}

- (void)handleRightEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    // Get the current view we are touching
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
    if (self.sideMenu.isOpen)
        [self.sideMenu close];
    else
        [self.sideMenu open];
    }
}
//4. Conform to the UIGestureRecognizerDelegate delegate protocol (optional). See #1 above on how to conform to the delegate in the .m file using the Class Extension syntax.

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // You can customize the way in which gestures can work
    // Enabling multiple gestures will allow all of them to work together, otherwise only the topmost view's gestures will work (i.e. PanGesture view on bottom)
    return YES;
}
@end
