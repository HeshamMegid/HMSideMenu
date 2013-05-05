//
//  ViewController.m
//  HMSideMenu
//
//  Created by Hesham Abd-Elmegid on 4/24/13.
//  Copyright (c) 2013 Hesham Abd-Elmegid. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HMSideMenuItem *twitterItem = [[HMSideMenuItem alloc] initWithSize:CGSizeMake(40, 40) action:^{
        NSLog(@"tapped twitter item");
    }];

    UIImageView *twitterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterIcon setImage:[UIImage imageNamed:@"twitter"]];
    [twitterItem addSubview:twitterIcon];
    
    HMSideMenuItem *emailItem = [[HMSideMenuItem alloc] initWithSize:CGSizeMake(40, 40) action:^{
        NSLog(@"tapped email item");
    }];
    
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30 , 30)];
    [emailIcon setImage:[UIImage imageNamed:@"email"]];
    [emailItem addSubview:emailIcon];
    
    HMSideMenuItem *facebookItem = [[HMSideMenuItem alloc] initWithSize:CGSizeMake(40, 40) action:^{
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
    
    HMSideMenuItem *browserItem = [[HMSideMenuItem alloc] initWithSize:CGSizeMake(40, 40) action:^{
        NSLog(@"tapped browser item");
    }];
    
    UIImageView *browserIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserIcon setImage:[UIImage imageNamed:@"browser"]];
    [browserItem addSubview:browserIcon];

    self.sideMenu = [[HMSideMenu alloc] initWithItems:@[twitterItem, emailItem, facebookItem, browserItem]];
    [self.sideMenu setSpacing:25.0f];
    [self.view addSubview:self.sideMenu];
}

- (IBAction)toggleMenu:(id)sender {
    if (self.sideMenu.isOpen)
        [self.sideMenu close];
    else
        [self.sideMenu open];
}

@end
