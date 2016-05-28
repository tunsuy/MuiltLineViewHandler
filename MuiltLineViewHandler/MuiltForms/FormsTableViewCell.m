
//
//  FormsTableViewCell.m
//  MuiltLineViewHandler
//
//  Created by tunsuy on 5/5/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "FormsTableViewCell.h"

@interface FormsTableViewCell ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation FormsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height);
//    
//}

- (void)setUpSubViews {
    _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPublicFormPaddingLeft, 0, 0, kPublicFormMinHeight)];
    _leftTitleLabel.font = [UIFont systemFontOfSize:kPublicFormItemTextFontLeft];
    _leftTitleLabel.textAlignment = NSTextAlignmentLeft;

    _midValueTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTitleLabel.frame)+kPublicFormMargin, 0, SCREEN_WIDTH-kPublicFormPaddingLeft-self.leftTitleLabel.bounds.size.width-kPublicFormMargin-kPublicFormPaddingRight, kPublicFormMinHeight)];
    _midValueTextField.font = [UIFont systemFontOfSize:kPublicFormItemTextFontRight];
    
    _midValueTextView = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTitleLabel.frame)+kPublicFormMargin, kTextViewOriginY, SCREEN_WIDTH-kPublicFormPaddingLeft-self.leftTitleLabel.bounds.size.width-kPublicFormMargin-kPublicFormPaddingRight, kPublicFormMinHeight-kTextViewOriginY*2)];
    _midValueTextView.font = [UIFont systemFontOfSize:kPublicFormItemTextFontRight];
    _midValueTextView.delegate = self;
//    _midValueTextView.scrollEnabled = NO;
    _placeHolderLabel = [[UILabel alloc] init];
    _placeHolderLabel.frame = CGRectMake(0, 0, _midValueTextView.bounds.size.width, _midValueTextView.bounds.size.height);
    _placeHolderLabel.textColor = [UIColor lightGrayColor];
    _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
    [_midValueTextView addSubview:_placeHolderLabel];
    
    _midValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTitleLabel.frame)+kPublicFormMargin, 0, SCREEN_WIDTH-kPublicFormPaddingLeft-self.leftTitleLabel.bounds.size.width-kPublicFormMargin-kPublicFormPaddingRight, kPublicFormMinHeight)];
    _midValueLabel.font = [UIFont systemFontOfSize:kPublicFormItemTextFontRight];
    _midValueLabel.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_leftTitleLabel];
    [self.contentView addSubview:_midValueLabel];
    [self.contentView addSubview:_midValueTextField];
    [self.contentView addSubview:_midValueTextView];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(cellTextViewDidChange:placeholder:)]) {
        [self.delegate cellTextViewDidChange:textView placeholder:self.placeHolderLabel];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(cellTextViewDidDidBeginEditing:)]) {
        [self.delegate cellTextViewDidDidBeginEditing:textView];
    }
}

- (void)setCellMidValueViewType:(CellMidValueViewType)cellMidValueViewType {
    switch (cellMidValueViewType) {
        case CellMidValueViewTypeLabel:
            self.midValueLabel.hidden = NO;
            self.midValueTextField.hidden = YES;
            self.midValueTextView.hidden = YES;
            break;
        case CellMidValueViewTypeTextField:
            self.midValueTextField.hidden = NO;
            self.midValueLabel.hidden = YES;
            self.midValueTextView.hidden = YES;
            break;
        case CellMidValueViewTypeTextView:
            self.midValueTextView.hidden = NO;
            self.midValueLabel.hidden = YES;
            self.midValueTextField.hidden = YES;
            
        default:
            break;
    }
}

- (void)setUiDataDic:(NSDictionary *)uiDataDic {
    if (_uiDataDic != uiDataDic) {
        _uiDataDic = uiDataDic;
        NSString *leftTitle = _uiDataDic[@"title"];
        self.leftTitleLabel.text = leftTitle;
        [self setLeftTitleLabelFrameWithTitle:leftTitle];
        [self setMidValueViewFrameWithValue:@""];
        
        NSString *placeHolder = _uiDataDic[@"placeholder"];
        self.midValueTextField.placeholder = placeHolder;
        self.placeHolderLabel.text = placeHolder;
    }
}

- (void)setValueStr:(NSString *)valueStr {
    self.midValueTextField.text = valueStr;
    self.midValueTextView.text = valueStr;
    
    [self setMidValueViewFrameWithValue:valueStr];
}

- (void)setLeftTitleLabelFrameWithTitle:(NSString *)title {
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kPublicFormItemTextFontLeft]}];
    CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, size.height) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kPublicFormItemTextFontLeft]} context:nil];
    CGRect frame = self.leftTitleLabel.frame;
    frame.size.width = rect.size.width;
    self.leftTitleLabel.frame = frame;
}

- (void)setMidValueViewFrameWithValue:(NSString *)value {
    self.midValueTextField.frame = CGRectMake(CGRectGetMaxX(self.leftTitleLabel.frame)+kPublicFormMargin, 0, SCREEN_WIDTH-kPublicFormPaddingLeft-self.leftTitleLabel.bounds.size.width-kPublicFormMargin-kPublicFormPaddingRight, kPublicFormMinHeight);
    
    CGRect rect = [value boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-kPublicFormPaddingLeft-self.leftTitleLabel.frame.size.width-kPublicFormPaddingRight-kPublicFormMargin, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kPublicFormItemTextFontRight]} context:nil];
    self.midValueTextView.frame = CGRectMake(CGRectGetMaxX(self.leftTitleLabel.frame)+kPublicFormMargin, kTextViewOriginY, SCREEN_WIDTH-kPublicFormPaddingLeft-self.leftTitleLabel.bounds.size.width-kPublicFormMargin-kPublicFormPaddingRight, MAX(rect.size.height, kPublicFormMinHeight-kTextViewOriginY*2));
    self.placeHolderLabel.frame = CGRectMake(0, 0, _midValueTextView.bounds.size.width, _midValueTextView.bounds.size.height);
    
    self.midValueLabel.frame = CGRectMake(CGRectGetMaxX(self.leftTitleLabel.frame)+kPublicFormMargin, 0, SCREEN_WIDTH-kPublicFormPaddingLeft-self.leftTitleLabel.bounds.size.width-kPublicFormMargin-kPublicFormPaddingRight, MAX(rect.size.height, kPublicFormMinHeight));
}

+ (CGFloat)getCellRealHeightWithCellValue:(NSString *)valueStr titleStr:(NSString *)titleStr {
//    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:valueStr];
//    NSRange range = NSMakeRange(0, attributeStr.length);
//    NSDictionary *dic = [attributeStr attributesAtIndex:0 effectiveRange:&range];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:kPublicFormItemTextFontRight], NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize titleStrSize = [titleStr sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kPublicFormItemTextFontLeft]}];
    CGRect rect = [valueStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-kPublicFormPaddingLeft-titleStrSize.width-kPublicFormPaddingRight-kPublicFormMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return MAX(rect.size.height + kTextViewOriginY*2, kPublicFormMinHeight);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
