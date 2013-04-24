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

@end

@implementation HMSideMenu

- (id)initWithItems:(NSArray *)items {
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.items = items;
        [self setAnimationDuration:1.0f];
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
    [self animateLayer:item.layer
           withKeyPath:@"position.x"
                    to:item.layer.position.x - self.menuWidth];
}

- (void)hideItem:(HMSideMenuItem *)item {
    [self animateLayer:item.layer
           withKeyPath:@"position.x"
                    to:item.layer.position.x + self.menuWidth];
}

#pragma mark - UIView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isOpen) {
        for (HMSideMenuItem *item in self.items)
            if (CGRectContainsPoint(item.frame, point)) return YES;
    } else if (!self.isOpen && CGRectContainsPoint(self.frame, point)) {
        return YES;
    }
   
    return NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.menuWidth = 0;
    CGFloat __block biggestHeight = 0;
    
    [self.items enumerateObjectsUsingBlock:^(HMSideMenuItem *item, NSUInteger idx, BOOL *stop) {
        self.menuWidth = MAX(item.frame.size.width, self.menuWidth);
        biggestHeight = MAX(item.frame.size.height, biggestHeight);
    }];
    
    CGFloat menuHeight = (biggestHeight * self.items.count) + (self.verticalSpacing * (self.items.count - 1));
    CGFloat y = (self.superview.frame.size.height / 2) - (menuHeight / 2);
    self.frame = CGRectMake(self.superview.frame.size.width, y, self.menuWidth, menuHeight);;
    
    [self.items enumerateObjectsUsingBlock:^(HMSideMenuItem *item, NSUInteger idx, BOOL *stop) {
        [item setCenter:CGPointMake(self.frame.size.width / 2, (idx * biggestHeight) + (idx * self.verticalSpacing) + (biggestHeight / 2))];
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
    layer.position = CGPointMake(endValue, layer.position.y);
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
