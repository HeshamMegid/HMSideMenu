//
//  ViewController.h
//  HMSideMenu
//
//  Created by Hesham Abd-Elmegid on 4/24/13.
//  Copyright (c) 2013 Hesham Abd-Elmegid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSideMenu.h"

@interface ViewController : UIViewController

@property (nonatomic, assign) BOOL menuIsVisible;
@property (nonatomic, strong) HMSideMenu *sideMenu;

- (IBAction)toggleMenu:(id)sender;

@end
