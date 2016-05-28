//
//  FormsTableViewCell.h
//  MuiltLineViewHandler
//
//  Created by tunsuy on 5/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTextViewOriginY 7

typedef NS_ENUM(NSInteger, CellMidValueViewType) {
    CellMidValueViewTypeLabel = 0,
    CellMidValueViewTypeTextField,
    CellMidValueViewTypeTextView
};

@protocol FormsTableViewCellDelegate <NSObject>

- (void)cellTextViewDidChange:(UITextView *)textView placeholder:(UILabel *)placeholder;
- (void)cellTextViewDidDidBeginEditing:(UITextView *)textView;

@end

@interface FormsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UITextView *midValueTextView;
@property (nonatomic, strong) UITextField *midValueTextField;
@property (nonatomic, strong) UILabel *midValueLabel;

@property (nonatomic, copy) NSDictionary *uiDataDic;
@property (nonatomic, copy) NSString *valueStr;

@property (nonatomic, weak) id<FormsTableViewCellDelegate> delegate;

- (void)setCellMidValueViewType:(CellMidValueViewType)cellMidValueViewType;
+ (CGFloat)getCellRealHeightWithCellValue:(NSString *)valueStr titleStr:(NSString *)titleStr;

@end
