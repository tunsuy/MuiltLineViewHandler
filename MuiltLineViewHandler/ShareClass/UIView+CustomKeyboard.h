//
//  UIView+CustomKeyboard.h
//  MuiltLineViewHandler
//
//  Created by tunsuy on 7/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KeyboardDismissType) {
    KeyboardDismissTypeDefault = 0,
    KeyboardDismissTypeAnyClick,
    KeyboardDismissTypePulldown,
    KeyboardDismissTypePullUpOrDown
};

@interface UIView (CustomKeyboard)<UIGestureRecognizerDelegate>

- (void)releaseResource;
- (void)setKeyboardDismissType:(KeyboardDismissType)keyboardDismissType;

@end
