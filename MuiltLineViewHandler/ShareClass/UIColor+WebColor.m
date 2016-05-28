//
//  UIColor+WebColor.m
//  MuiltLineViewHandler
//
//  Created by tunsuy on 1/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "UIColor+WebColor.h"

@implementation UIColor (WebColor)

+ (UIColor *) colorWithHexString:(const NSString *)colorStr alpha:(CGFloat)alp{
    NSString *myColorStr = [colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (myColorStr.length < 6) {
        return [UIColor clearColor];
    }
    if ([myColorStr hasPrefix:@"0X"] || [myColorStr hasPrefix:@"0x"]) {
        myColorStr = [myColorStr substringFromIndex:2];
    }else if ([myColorStr hasPrefix:@"#"]){
        myColorStr = [myColorStr substringFromIndex:1];
    }
    if (myColorStr.length != 6) {
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rColorStr = [myColorStr substringWithRange:range];
    range.location = 2;
    NSString *gColorStr = [myColorStr substringWithRange:range];
    range.location = 4;
    NSString *bColorStr = [myColorStr substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rColorStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gColorStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bColorStr] scanHexInt:&b];
    
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:alp];
    
}

@end
