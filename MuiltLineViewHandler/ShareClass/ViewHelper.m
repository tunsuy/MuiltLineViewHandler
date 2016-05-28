//
//  ViewHelper.m
//  MuiltLineViewHandler
//
//  Created by tunsuy on 29/2/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "ViewHelper.h"

@implementation ViewHelper

+ (CGFloat) calculateLabelTextWidth:(UILabel *)label withFont:(UIFont *)textFont{
    CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:textFont}];
    return size.width;
}

//为什么设置成父view的宽度不行，
//为什么使用textview的delege不行，而用通知可以
+ (CGFloat) calculateHeightWithTextView:(UITextView *)textView withTextFont:(UIFont *)textFont{
    CGSize size = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, CGFLOAT_MAX) ];
    return size.height;
}

+ (void) setLeftLabelValue:(UILabel *)label WithText:(NSString *)textStr{
    label.text = textStr;
}

+ (void) setLeftLabelRealWidth:(UILabel *)label{
    CGRect frame = label.frame;
    frame.size.width = [ViewHelper calculateLabelTextWidth:label withFont:[UIFont systemFontOfSize:kFontOfText]];
    label.frame = frame;
    
}

@end
