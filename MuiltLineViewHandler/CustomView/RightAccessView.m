//
//  RightAccessView.m
//  MuiltLineViewHandler
//
//  Created by tunsuy on 2/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "RightAccessView.h"

#define kSubviewToViewHorizonMargin 10
#define kSubviewToViewVerticalMargin 5
#define kRightAccessViewWidth 10

@implementation RightAccessView

- (void) drawRect:(CGRect)rect{
    CGRect frame = self.midDisplayLabel.frame;
    frame.size.height = self.frame.size.height-kSubviewToViewVerticalMargin-15;
    self.midDisplayLabel.frame = frame;
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self generateView];
    }
    return self;
}

- (void) generateView{
    self.leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height-kSubviewToViewVerticalMargin-15)];
    self.leftTitleLabel.font = [UIFont systemFontOfSize:kFontOfText];
    [self addSubview:self.leftTitleLabel];
    
    self.midDisplayLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSubviewToViewHorizonMargin+self.leftTitleLabel.frame.size.width, 0, self.frame.size.width-kSubviewToViewHorizonMargin*2-self.leftTitleLabel.frame.size.width-kRightAccessViewWidth, self.frame.size.height-kSubviewToViewVerticalMargin-15)];
    self.midDisplayLabel.font = [UIFont systemFontOfSize:kFontOfText];
    self.midDisplayLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.midDisplayLabel.numberOfLines = 0;
    [self addSubview:self.midDisplayLabel];
    
    self.rightAccessView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-kRightAccessViewWidth, 0, kRightAccessViewWidth, self.frame.size.height-kSubviewToViewVerticalMargin-15)];
    CALayer *layer = [self generateRightAccessView];
    [self.rightAccessView.layer addSublayer:layer];
    [self addSubview:self.rightAccessView];
    
    self.displayBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSubviewToViewHorizonMargin+self.leftTitleLabel.frame.size.width, self.midDisplayLabel.frame.origin.y+self.midDisplayLabel.frame.size.height+kSubviewToViewVerticalMargin, 50, 15)];
    self.displayBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.displayBtn setTitle:@"" forState:UIControlStateNormal];
    [self.displayBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:self.displayBtn];
    
}

- (CALayer *) generateRightAccessView{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, kSubviewToViewVerticalMargin)];
    [path addLineToPoint:CGPointMake(kRightAccessViewWidth, self.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height-kSubviewToViewVerticalMargin)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    return shapeLayer;
}

- (void) setLeftLabelValueWithText:(NSString *)textStr{
    [ViewHelper setLeftLabelValue:self.leftTitleLabel WithText:textStr];
}

- (void) setLeftLabelRealWidth{
    [ViewHelper setLeftLabelRealWidth:self.leftTitleLabel];
    CGRect frame = self.midDisplayLabel.frame;
    frame.origin.x = kSubviewToViewHorizonMargin+self.leftTitleLabel.frame.size.width;
    frame.size.width = self.frame.size.width-kSubviewToViewHorizonMargin*2-self.leftTitleLabel.frame.size.width-kRightAccessViewWidth;
    self.midDisplayLabel.frame = frame;
    
}

- (void) setMidLabelRealHeight{
    
//    CGSize size = [self.midDisplayLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kFontOfText]}];
    CGSize size = [self.midDisplayLabel sizeThatFits:CGSizeMake(self.midDisplayLabel.frame.size.width, MAXFLOAT)];
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    [self setNeedsDisplay];
    
}

@end
