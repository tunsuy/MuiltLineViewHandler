//
//  ViewHelper.h
//  MuiltLineViewHandler
//
//  Created by tunsuy on 29/2/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewHelper : NSObject

+ (CGFloat) calculateLabelTextWidth:(UILabel *)label withFont:(UIFont *)textFont;
+ (CGFloat) calculateHeightWithTextView:(UITextView *)textView withTextFont:(UIFont *)textFont;

+ (void) setLeftLabelValue:(UILabel *)label WithText:(NSString *)textStr;
+ (void) setLeftLabelRealWidth:(UILabel *)label;

@end
