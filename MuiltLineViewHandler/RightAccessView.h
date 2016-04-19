//
//  RightAccessView.h
//  MuiltLineViewHandler
//
//  Created by tunsuy on 2/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightAccessView : UIView

@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UILabel *midDisplayLabel;
@property (nonatomic, strong) UIView *rightAccessView;
@property (nonatomic, strong) UIButton *displayBtn;

- (void) setLeftLabelValueWithText:(NSString *)textStr;
- (void) setLeftLabelRealWidth;
- (void) setMidLabelRealHeight;

@end
