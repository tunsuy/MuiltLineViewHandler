//
//  RightTextView.h
//  MuiltLineViewHandler
//
//  Created by tunsuy on 29/2/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightTextView : UIView <UITextViewDelegate>

@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UITextView *rightTextView;

- (void) setLeftLabelValueWithText:(NSString *)textStr;
- (void) setLeftLabelRealWidth;
- (void) setRightTextViewRealHeight;

@end
