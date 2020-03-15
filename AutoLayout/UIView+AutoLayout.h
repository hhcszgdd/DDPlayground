//
//  UIView+AutoLayout.h
//  MyPlayground
//
//  Created by JohnConnor on 2020/3/15.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, AutolayoutInset) {

    Top = 1<<0,
    Left = 1<<1,
    Bottom = 1<<2,
    Right = 1<<3

};

typedef struct{
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
    
}AutolayoutMargin;

UIKIT_STATIC_INLINE AutolayoutMargin AutolayoutMarginMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    AutolayoutMargin  margins ;
    margins.top = top;
    margins.left = left;
    margins.bottom = bottom;
    margins.right = right;
    return margins ;
}


NS_ASSUME_NONNULL_BEGIN

@interface UIView (AutoLayout)

- (void)add:(UIView*)subview pin:(AutolayoutInset) inset margin:(AutolayoutMargin) margins ;
- (void)setupHeight:(CGFloat)height;
- (void)setupWidth:(CGFloat)width;
- (void)setupSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
