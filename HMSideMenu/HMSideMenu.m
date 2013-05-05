//
//  HMSideMenu.m
//  HMSideMenu
//
//  Created by Hesham Abd-Elmegid on 4/24/13.
//  Copyright (c) 2013 Hesham Abd-Elmegid. All rights reserved.
//

#import "HMSideMenu.h"
#import <QuartzCore/QuartzCore.h>

#define kAnimationDelay 0.08

typedef CGFloat (^EasingFunction)(CGFloat, CGFloat, CGFloat, CGFloat);

@interface HMSideMenu ()

@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, assign) CGFloat menuHeight;

- (BOOL)menuIsVertical;

@end

@implementation HMSideMenu

- (id)initWithItems:(NSArray *)items {
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.items = items;
        _animationDuration = 1.3f;
        _menuPosition = HMSideMenuPositionRight;
    }
    
    return self;
}

- (void)setItems:(NSArray *)items {
    // Remove all current items in case we are changing the menu items.
    for (HMSideMenuItem *item in items) {
        [item removeFromSuperview];
    }
    
    _items = items;
    
    for (HMSideMenuItem *item in items) {
        [self addSubview:item];
    }
}

- (void)open {
    _isOpen = YES;
    
    for (HMSideMenuItem *item in self.items) {
        [self performSelector:@selector(showItem:) withObject:item afterDelay:kAnimationDelay * [self.items indexOfObject:item]];
    }
}

- (void)close {
    _isOpen = NO;
    
    for (HMSideMenuItem *item in self.items) {
        [self performSelector:@selector(hideItem:) withObject:item afterDelay:kAnimationDelay * [self.items indexOfObject:item]];
    }
}

- (void)showItem:(HMSideMenuItem *)item {
    CGPoint position = item.layer.position;
    
    if (self.menuIsVertical) {
        position.x += self.menuPosition == HMSideMenuPositionRight ? - self.menuWidth : self.menuWidth;
        
        [self animateLayer:item.layer
               withKeyPath:@"position.x"
                        to:position.x];
    } else {
        position.y += self.menuPosition == HMSideMenuPositionTop ? self.menuHeight : - self.menuHeight;

        [self animateLayer:item.layer
               withKeyPath:@"position.y"
                        to:position.y];
    }
    
    item.layer.position = position;
}

- (void)hideItem:(HMSideMenuItem *)item {
    CGPoint position = item.layer.position;
    
    if (self.menuIsVertical) {
        position.x += self.menuPosition == HMSideMenuPositionRight ? self.menuWidth : - self.menuWidth;
        
        [self animateLayer:item.layer
               withKeyPath:@"position.x"
                        to:position.x];
    } else {
        position.y += self.menuPosition == HMSideMenuPositionTop ? - self.menuHeight : self.menuHeight;
        
        [self animateLayer:item.layer
               withKeyPath:@"position.y"
                        to:position.y];
    }
    
    item.layer.position = position;
}

- (BOOL)menuIsVertical {
    if (self.menuPosition == HMSideMenuPositionLeft || self.menuPosition == HMSideMenuPositionRight)
        return YES;
    
    return NO;
}

#pragma mark - UIView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    for (HMSideMenuItem *item in self.items) {
        if (CGRectContainsPoint(item.frame, point))
            return YES;
    }
   
    return NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.menuWidth = 0;
    self.menuHeight = 0;
    CGFloat __block biggestHeight = 0;
    CGFloat __block biggestWidth = 0;
    
   // Calculate the menu size
    if (self.menuIsVertical) {
        [self.items enumerateObjectsUsingBlock:^(HMSideMenuItem *item, NSUInteger idx, BOOL *stop) {
            self.menuWidth = MAX(item.frame.size.width, self.menuWidth);
            biggestHeight = MAX(item.frame.size.height, biggestHeight);
        }];
        
        self.menuHeight = (biggestHeight * self.items.count) + (self.itemSpacing * (self.items.count - 1));
    } else { //if (self.position == HMSideMenuPositionTop || self.position == HMSideMenuPositionBottom) {
        [self.items enumerateObjectsUsingBlock:^(HMSideMenuItem *item, NSUInteger idx, BOOL *stop) {
            self.menuHeight = MAX(item.frame.size.height, self.menuHeight);
            biggestWidth = MAX(item.frame.size.width, biggestWidth);
        }];
        
        self.menuWidth = (biggestWidth * self.items.count) + (self.itemSpacing * (self.items.count - 1));
    }
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat itemInitialX = 0;

    if (self.menuIsVertical) {
        x = self.menuPosition == HMSideMenuPositionRight ? self.superview.frame.size.width : 0 - self.menuWidth;
        y  = (self.superview.frame.size.height / 2) - (self.menuHeight / 2);
        itemInitialX = self.menuWidth / 2;
    } else {
        x = self.superview.frame.size.width / 2 - (self.menuWidth / 2);
        y = self.menuPosition == HMSideMenuPositionTop ? 0 - self.menuHeight : self.superview.frame.size.height;
    }
    
    self.frame = CGRectMake(x, y, self.menuWidth, self.menuHeight);;
    
    // Layout the items
    [self.items enumerateObjectsUsingBlock:^(HMSideMenuItem *item, NSUInteger idx, BOOL *stop) {
        if (self.menuIsVertical)
            [item setCenter:CGPointMake(itemInitialX, (idx * biggestHeight) + (idx * self.itemSpacing) + (biggestHeight / 2))];
        else
            [item setCenter:CGPointMake((idx * biggestWidth) + (idx * self.itemSpacing) + (biggestWidth / 2), self.menuHeight / 2)];
    }];
}

#pragma mark - Animation

- (void)animateLayer:(CALayer *)layer
         withKeyPath:(NSString *)keyPath
                  to:(CGFloat)endValue {
    CGFloat startValue = [[layer valueForKeyPath:keyPath] floatValue];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = self.animationDuration;
    
    CGFloat steps = 100;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:steps];
    CGFloat delta = endValue - startValue;
    EasingFunction function = easeOutElastic;
    
    for (CGFloat t = 0; t < steps; t++) {
        [values addObject:@(function(animation.duration * (t / steps), startValue, delta, animation.duration))];
    }
    
    animation.values = values;
    [layer addAnimation:animation forKey:nil];
}

static EasingFunction easeOutElastic = ^CGFloat(CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    CGFloat amplitude = 5;
    CGFloat period = 0.6;
    CGFloat s = 0;
    if (t == 0) {
        return b;
    }
    else if ((t /= d) == 1) {
        return b + c;
    }
    
    if (!period) {
        period = d * .3;
    }
    
    if (amplitude < abs(c)) {
        amplitude = c;
        s = period / 4;
    }
    else {
        s = period / (2 * M_PI) * sin(c / amplitude);
    }
    
    return (amplitude * pow(2, -10 * t) * sin((t * d - s) * (2 * M_PI) / period) + c + b);
};

@end
