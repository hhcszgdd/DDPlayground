//
//  UIView+AutoLayout.m
//  MyPlayground
//
//  Created by JohnConnor on 2020/3/15.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

#import "UIView+AutoLayout.h"
#import "MyPlayground-Swift.h"
#import "DDSingleInstance.h"
@implementation UIView (AutoLayout)

- (void)setupHeight:(CGFloat)height{
//    [DDMultipleThread share];
//    [[DDMultipleThread share] testGCDSync];
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    [[self.heightAnchor constraintEqualToConstant:height] setActive:YES];
}
- (void)setupWidth:(CGFloat)width{
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    [[self.widthAnchor constraintEqualToConstant:width] setActive:YES];
}

- (void)setupSize:(CGSize)size{
    if (!self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    [[self.widthAnchor constraintEqualToConstant:size.width] setActive:YES];
    [[self.heightAnchor constraintEqualToConstant:size.height] setActive:YES];
}

- (void)add:(UIView*)subview pin:(AutolayoutInset) inset margin:(AutolayoutMargin) margins {
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:subview];
    if (inset & Top)  {
        [[subview.topAnchor constraintEqualToAnchor:self.topAnchor constant:margins.top] setActive:YES];
    }
    if (inset & Left)  {
        [[subview.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:margins.left] setActive:YES];
    }
    if (inset & Bottom)  {
        [[subview.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:margins.bottom] setActive:YES];
    }
    if (inset & Right)  {
        [[subview.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:margins.right] setActive:YES];
    }
}

@end
