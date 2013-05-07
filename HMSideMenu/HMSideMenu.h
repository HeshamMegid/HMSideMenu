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
 An array of `HMSideMenuItem` objects. Read only property, hence should be set using `initWithItems:`.
 */
@property (nonatomic, strong, readonly) NSArray *items;

/**
 Current state of the side menu.
 */
@property (nonatomic, assign, readonly) BOOL isOpen;

/**
 Vertical/horizontal Spacing between each menu item and the next.
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

/**
 Initialize the menu with an array of items.
 @param items An array of `HMSideMenuItems`.
 */
- (id)initWithItems:(NSArray *)items;

/**
 Show all menu items with animation.
 */
- (void)open;

/**
 Hide all menu items with animation.
 */
- (void)close;

@end

/**
 A category on UIView to attach a given block as an action for a single tap.
 Credit: http://www.cocoanetics.com/2012/06/associated-objects/
 @param block The block to execute.
 */
@interface UIView (DTActionHandlers)

- (void)setTapActionWithBlock:(void (^)(void))block;

@end