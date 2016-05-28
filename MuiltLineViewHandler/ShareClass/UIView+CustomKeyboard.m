//
//  UIView+CustomKeyboard.m
//  MuiltLineViewHandler
//
//  Created by tunsuy on 7/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "UIView+CustomKeyboard.h"
#import <objc/runtime.h>

static char *const keyboardDismissTypeKey = "keyboardDismissTypeKey";
static char *const gestureKey = "gestureKey";
static char *const isAddTextFieldObserverKey = "isAddTextFieldObserverKey";
static char *const isAddTextViewObserverKey = "isAddTextViewObserverKey";
static char *const activeTextObjectKey = "activeTextObjectKey";

@implementation UIView (CustomKeyboard)

- (void)releaseResource {
    if ([self isAddTextFieldObserver]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
        [self setIsAddTextFieldObserver:NO];
    }
    if ([self isAddTextViewObserver]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
        [self setIsAddTextViewObserver:NO];
    }
    [self setGesture:nil];
}

- (KeyboardDismissType)keyboardDismissType {
    return [objc_getAssociatedObject(self, keyboardDismissTypeKey) integerValue];
}

- (void)setKeyboardDismissType:(KeyboardDismissType)keyboardDismissType {
    objc_setAssociatedObject(self, keyboardDismissTypeKey, @(keyboardDismissType), OBJC_ASSOCIATION_COPY);
    
    if (keyboardDismissType != KeyboardDismissTypeDefault) {
        UIGestureRecognizer *gesture = nil;
        if (keyboardDismissType == KeyboardDismissTypePulldown || keyboardDismissType == KeyboardDismissTypePullUpOrDown) {
            UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureGenerate:)];
            [panGesture setMinimumNumberOfTouches:1];
            gesture = panGesture;
        }
        else {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureGenerate:)];
            gesture = tapGesture;
        }
        
        gesture.delegate = self;
        [self addGestureRecognizer:gesture];
        [self setGesture:gesture];
        
        if (![self isAddTextFieldObserver]) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
            [self setIsAddTextFieldObserver:YES];
        }
        if (![self isAddTextViewObserver]) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
            [self setIsAddTextViewObserver:YES];
        }
    }
}

- (void)setGesture:(UIGestureRecognizer *)gesture {
    objc_setAssociatedObject(self, gestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isAddTextFieldObserver {
    return [objc_getAssociatedObject(self, isAddTextFieldObserverKey) boolValue];
}

- (void)setIsAddTextFieldObserver:(BOOL)isAddTextFeildObserver {
    objc_setAssociatedObject(self, isAddTextFieldObserverKey, @(isAddTextFeildObserver), OBJC_ASSOCIATION_COPY);
}

- (BOOL)isAddTextViewObserver {
    return [objc_getAssociatedObject(self, isAddTextViewObserverKey) boolValue];
}

- (void)setIsAddTextViewObserver:(BOOL)isAddTextViewObserver {
    objc_setAssociatedObject(self, isAddTextViewObserverKey, @(isAddTextViewObserver), OBJC_ASSOCIATION_COPY);
}

- (id)activeTextObject {
    return objc_getAssociatedObject(self, activeTextObjectKey);
}

- (void)setActiveTextObject:(id)textObject {
    objc_setAssociatedObject(self, activeTextObjectKey, textObject, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - observer selector
- (void)gestureGenerate:(UIGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self];
    CGFloat originY = self.frame.origin.y;
    
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if ([window isKindOfClass:NSClassFromString(@"UITextEffectsWindow")]) {
            for (UIView *view in window.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"UIInputSetContainerView")]) {
                    for (UIView *subView in view.subviews) {
                        if ([subView isKindOfClass:NSClassFromString(@"UIInputSetHostView")]) {
                            originY = subView.frame.origin.y;
                            break;
                        }
                    }
                }
            }
        }
    }
    
    KeyboardDismissType type = [self keyboardDismissType];
    if (type == KeyboardDismissTypePulldown) {
        if (point.y > originY) {
            [self dismissKeyboard];
        }
    }
    else if (type == KeyboardDismissTypePullUpOrDown || type == KeyboardDismissTypeAnyClick) {
        [self dismissKeyboard];
    }
}

- (void)textDidBeginEditing:(NSNotification *)noti {
    UIView *view = noti.object;
    if ([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]]) {
        UIView *superView = view.superview;
        while (superView) {
            if (superView == self) {
                [self setActiveTextObject:view];
                return;
            }
            superView = superView.superview;
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    KeyboardDismissType type = [self keyboardDismissType];
    if (type == KeyboardDismissTypePulldown || type == KeyboardDismissTypePullUpOrDown) {
        return YES;
    }
    else if (type == KeyboardDismissTypeAnyClick) {
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    KeyboardDismissType type = [self keyboardDismissType];
    if (type == KeyboardDismissTypePulldown || type == KeyboardDismissTypePullUpOrDown) {
        return YES;
    }
    else if (type == KeyboardDismissTypeAnyClick) {
        UIView *view = [touch view];
        if ([view isKindOfClass:[UIControl class]]  && ((UIControl *)view).enabled) {
            return NO;
        }
        return YES;
    }
    return YES;
}

#pragma mark - private selector
- (void)dismissKeyboard {
    [[self activeTextObject] resignFirstResponder];
    [self setActiveTextObject:nil];
}

@end
