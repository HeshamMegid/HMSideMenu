//
//  HMMenuItem.h
//  HMSideMenu
//
//  Created by Hesham Abd-Elmegid on 4/24/13.
//  Copyright (c) 2013 Hesham Abd-Elmegid. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ItemActionBlock)(void);

@interface HMSideMenuItem : UIView

@property (nonatomic, strong) ItemActionBlock action;

- (id)initWithSize:(CGSize)size action:(ItemActionBlock)action;

@end
