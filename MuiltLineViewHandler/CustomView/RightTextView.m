//
//  RightTextView.m
//  MuiltLineViewHandler
//
//  Created by tunsuy on 29/2/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "RightTextView.h"
#import "ViewHelper.h"

#define kLeftLabelWidthMin 80
#define kLeftLabelToRightTextView 10
#define kTextViewDefaultLineCount 3

@implementation RightTextView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self generateView];
    }
    return  self;
}

- (void) generateView{
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kLeftLabelWidthMin, self.frame.size.height)];
    self.leftLabel.font = [UIFont systemFontOfSize:kFontOfText];
    [self addSubview:self.leftLabel];
    
    self.rightTextView = [[UITextView alloc] initWithFrame:CGRectMake(kLeftLabelWidthMin+kLeftLabelToRightTextView, 0, self.frame.size.width-kLeftLabelWidthMin-kLeftLabelToRightTextView, self.frame.size.height)];
    self.rightTextView.font = [UIFont systemFontOfSize:kFontOfText];
    self.rightTextView.layer.cornerRadius = 8;
    self.rightTextView.backgroundColor = [UIColor whiteColor];
    self.rightTextView.delegate = self;
    
    [self addSubview:self.rightTextView];
}

- (void) setLeftLabelValueWithText:(NSString *)textStr{
    [ViewHelper setLeftLabelValue:self.leftLabel WithText:textStr];
}

- (void) setLeftLabelRealWidth{
    [ViewHelper setLeftLabelRealWidth:self.leftLabel];
    
}

- (void) setRightTextViewRealHeight{
    CGRect frame = self.frame;
    frame.size.height = [ViewHelper calculateHeightWithTextView:self.rightTextView withTextFont:[UIFont systemFontOfSize:kFontOfText]];
    if (frame.size.height > kInputViewTop+kInputViewBottom+kFontOfText*kTextViewDefaultLineCount) {
        self.frame = frame;
        [self setNeedsLayout];
    }
    
}

- (void) layoutSubviews{
    CGRect frame = self.rightTextView.frame;
    frame.size.height = self.frame.size.height;
    self.rightTextView.frame = frame;
}

#pragma mark -- UITextViewDelege

//- (void) textViewDidChange:(UITextView *)textView{
//    [self calculateHeightWithTextView:textView withTextFont:[UIFont systemFontOfSize:kFontOfText]];
//}

//- (void) textViewDidBeginEditing:(UITextView *)textView{
//    [self calculateHeightWithTextView:textView withTextFont:[UIFont systemFontOfSize:kFontOfText]];
//}

//- (void) textViewDidEndEditing:(UITextView *)textView{
//    [self calculateHeightWithTextView:textView withTextFont:[UIFont systemFontOfSize:kFontOfText]];
//}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void) textViewDidBeginEditing:(UITextView *)textView{
    [textView becomeFirstResponder];
}

@end
