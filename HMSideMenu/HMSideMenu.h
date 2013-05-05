//
//  HMSideMenu.h
//  HMSideMenu
//
//  Created by Hesham Abd-Elmegid on 4/24/13.
//  Copyright (c) 2013 Hesham Abd-Elmegid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSideMenuItem.h"

typedef enum {
    HMSideMenuPositionLeft,
    HMSideMenuPositionRight,
    HMSideMenuPositionTop,
    HMSideMenuPositionBottom
} HMSideMenuPosition;

@interface HMSideMenu : UIView

/**
 An array of `HMSideMenuItem` objects. Read only property, hence should be set using the constructor `initWithItems:`.
 */
@property (nonatomic, strong, readonly) NSArray *items;

/**
 Side menu is open/closed.
 */
@property (nonatomic, assign, readonly) BOOL isOpen;

/**
 Vertical spacing between each menu item and the next.
 */
@property (nonatomic, assign) CGFloat itemSpacing;

/**
 Duration of the opening/closing animation.
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 Position the side menu will be added at.
 */
@property (nonatomic, assign) HMSideMenuPosition menuPosition;

- (id)initWithItems:(NSArray *)items;
- (void)open;
- (void)close;

@end
