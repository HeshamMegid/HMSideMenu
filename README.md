HMSideMenu
===

HMSideMenu allows you to display a menu of items that show from the left, right, top or bottom of a view controller with a delightful animation.

Check [this video](http://www.youtube.com/watch?v=2dswvXSdDzM) to see how exactly it works.

[![screenshot](screenshot.gif)](http://www.youtube.com/watch?v=2dswvXSdDzM)

# Features
- Menu items are UIView subclasses, so they are fully customizable.
- Supports blocks
- Works with ARC and iOS >= 5

# Installation

- Drag HMSideMenu folder to your project.
- Add `QuartzCore.framework` to your linked frameworks.
- `#import "HMSideMenu.h"` where you want to add the control.

# Usage

```  objective-c
HMSideMenuItem *twitterItem = [[HMSideMenuItem alloc] initWithSize:CGSizeMake(40, 40) action:^{
    NSLog(@"tapped twitter item");
}];

UIImageView *twitterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
[twitterIcon setImage:[UIImage imageNamed:@"twitter"]];
[twitterItem addSubview:twitterIcon];

HMSideMenu *sideMenu = [[HMSideMenu alloc] initWithItems:@[twitterItem]];
[self.sideMenu setVerticalSpacing:1.0f];
[self.view addSubview:self.sideMenu];
```

Please check the included demo project for more options.


# Change log
* v1.1.0
	* Added left, top and bottom menu positions
	* Code refactoring	
* v1.0.0
	* Initial release
	
# To do
* Support for orientation changes.

# Credits
Thanks to [@bryanoltman](https://github.com/bryanoltman/)'s [CAAnimation-EasingEquations](https://github.com/bryanoltman/CAAnimation-EasingEquations) for the animation easing function.

# License
HMSideMenu is licensed under the terms of the MIT License. Please see the [LICENSE](LICENSE.md) file for full details.

If this code was helpful, I would love to hear from you.

[@HeshamMegid](http://twitter.com/HeshamMegid)   
[http://hesh.am](http://hesh.am)