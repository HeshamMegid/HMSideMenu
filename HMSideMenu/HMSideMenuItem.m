//
//  HMMenuItem.m
//  HMSideMenu
//
//  Created by Hesham Abd-Elmegid on 4/24/13.
//  Copyright (c) 2013 Hesham Abd-Elmegid. All rights reserved.
//

#import "HMSideMenuItem.h"

@implementation HMSideMenuItem

- (id)initWithSize:(CGSize)size action:(ItemActionBlock)action {
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    if (self) {
        _action = action;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    
    return self;
}

- (void)didTapView:(UITapGestureRecognizer *)gesture {
    self.action();
}

@end
