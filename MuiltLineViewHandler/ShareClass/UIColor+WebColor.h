//
//  UIColor+WebColor.h
//  MuiltLineViewHandler
//
//  Created by tunsuy on 1/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WebColor)

+ (UIColor *) colorWithHexString:(const NSString *)colorStr alpha:(CGFloat)alp;

@end
