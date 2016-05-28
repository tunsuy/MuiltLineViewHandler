//
//  ViewController.m
//  MuiltLineViewHandler
//
//  Created by tunsuy on 29/2/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "ViewController.h"
#import "RightTextView.h"
#import "RightAccessView.h"
#import "FormsTableViewCell.h"
#import "UIView+CustomKeyboard.h"

#define kRightTextViewModeToLeft 10
#define kRightTextViewModeToRight 10
#define kTextViewDefaultLineCount 3
#define kViewMargin 15
#define kAccessViewWidthMin 30

#define kNeedDisplayLineCountsMin 2

#define kCellSubViewTagStart 2000

static BOOL displayFlag = NO;

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, FormsTableViewCellDelegate, UITextFieldDelegate>

@property (nonatomic, strong) RightTextView *rightTextViewMode;
@property (nonatomic) CGRect keyboardFrame;
@property (nonatomic, strong) RightAccessView *rightAccessView;
@property (nonatomic, strong) UIButton *displayBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *uiDataArr;
@property (nonatomic, strong) NSMutableDictionary *valueDataDic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.rightTextViewMode = [[RightTextView alloc] initWithFrame:CGRectMake(kRightTextViewModeToLeft, kStatusBarHeight, SCREEN_WIDTH-kRightTextViewModeToRight-kRightTextViewModeToLeft, kInputViewTop+kInputViewBottom+kFontOfText*kTextViewDefaultLineCount)];
//    [self.rightTextViewMode setLeftLabelValueWithText:@"多行文本测试"];
//    [self.rightTextViewMode setLeftLabelRealWidth];
//    [self.view addSubview:self.rightTextViewMode];
//    
//    [self.view setBackgroundColor:[UIColor colorWithHexString:@"EFEFF4" alpha:1.0]];
//    
//    self.rightAccessView = [[RightAccessView alloc] initWithFrame:CGRectMake(kRightTextViewModeToLeft, self.rightTextViewMode.frame.origin.y+self.rightTextViewMode.frame.size.height+kViewMargin, SCREEN_WIDTH-kRightTextViewModeToLeft-kRightTextViewModeToRight, kAccessViewWidthMin)];
//    [self.rightAccessView setLeftLabelValueWithText:@"展开收起"];
//    self.rightAccessView.midDisplayLabel.text = @"公司公司的三国杀的归属感是的是的发生的是的发生的是的发生的颂德歌功伤感的歌SD敢达高SD敢达高东方闪电是打发士大夫是打发士大夫是是打发士大夫是打发士大夫所发生的是的发生的";
//    [self.rightAccessView setLeftLabelRealWidth];
//    [self.rightAccessView setMidLabelRealHeight];
//    [self.view addSubview:self.rightAccessView];
//    
//    [self.rightAccessView.displayBtn addTarget:self action:@selector(displayChange) forControlEvents:UIControlEventTouchUpInside];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillShowNotification object:nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self loadUIData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChanged1:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChanged1:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view setKeyboardDismissType:KeyboardDismissTypePulldown];
}

#pragma mark - tableView
- (void)loadUIData {
    if (!_valueDataDic) {
        _valueDataDic = [[NSMutableDictionary alloc] init];
    }
    _uiDataArr = @[
                   @{
                       @"title": @"多行",
                       @"placeholder": @"输入多行",
                       @"cellMidValueViewType": @(CellMidValueViewTypeTextView),
                       @"cellID": @"muilt"
                       },
                   @{
                       @"title": @"单行",
                       @"placeholder": @"输入单行",
                       @"cellMidValueViewType": @(CellMidValueViewTypeTextField),
                       @"cellID": @"single"
                       },
                   @{
                       @"title": @"显示",
                       @"placeholder": @"输入显示",
                       @"cellMidValueViewType": @(CellMidValueViewTypeLabel),
                       @"cellID": @"show"
                       }
                   ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.uiDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"formCell";
    FormsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FormsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.midValueLabel.tag = kCellSubViewTagStart+indexPath.row;
    cell.midValueTextField.tag = kCellSubViewTagStart+indexPath.row;
    cell.midValueTextView.tag = kCellSubViewTagStart+indexPath.row;
    cell.delegate = self;
    cell.midValueTextField.delegate = self;
    [cell setCellMidValueViewType:[self.uiDataArr[indexPath.row][@"cellMidValueViewType"] integerValue]];
    NSDictionary *cellUIDataDic = @{@"title": self.uiDataArr[indexPath.row][@"title"],
                                    @"placeholder": self.uiDataArr[indexPath.row][@"placeholder"]};
    cell.uiDataDic = cellUIDataDic;
    NSString *valueKey = self.uiDataArr[indexPath.row][@"cellID"];
    cell.valueStr = self.valueDataDic[valueKey];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *valueKey = self.uiDataArr[indexPath.row][@"cellID"];
    NSString *valueStr = self.valueDataDic[valueKey];
    NSString *titleStr = self.uiDataArr[indexPath.row][@"title"];
    if ([self.uiDataArr[indexPath.row][@"cellMidValueViewType"] integerValue] == CellMidValueViewTypeTextView) {
        return [FormsTableViewCell getCellRealHeightWithCellValue:valueStr titleStr:titleStr];
    }
    return kPublicFormMinHeight;
}

//- (void)textViewDidEndEditing:(UITextView *)textView {
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textView.tag-kCellSubViewTagStart inSection:1];
//    NSString *valueKey = self.uiDataArr[indexPath.row][@"cellID"];
//
//    self.valueDataDic[valueKey] = textView.text?(textView.text.length>0 ? textView.text : @"") : @"";
//    
//    [self.tableView beginUpdates];
//    [self.tableView endUpdates];
//}

#pragma mark - FormsTableViewCellDelegate
- (void)cellTextViewDidChange:(UITextView *)textView placeholder:(UILabel *)placeholder {
    if ([textView.text isEqualToString:@""]) {
        placeholder.hidden = NO;
    }
    else {
        placeholder.hidden = YES;
    }

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textView.tag-kCellSubViewTagStart inSection:0];
    NSString *valueKey = self.uiDataArr[indexPath.row][@"cellID"];
    NSString *titleStr = self.uiDataArr[indexPath.row][@"title"];
    
    self.valueDataDic[valueKey] = textView.text?(textView.text.length>0 ? textView.text : @"") : @"";
    
    CGRect frame = textView.frame;
    frame.size.height = [FormsTableViewCell getCellRealHeightWithCellValue:self.valueDataDic[valueKey] titleStr:titleStr] - kTextViewOriginY*2;
    textView.frame = frame;
    __weak typeof(self) weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^(){
        [weakself.tableView beginUpdates];
        [weakself.tableView endUpdates];
    });
    
    
    [self scrollViewToVisibalWithView:textView];
}

- (void)cellTextViewDidDidBeginEditing:(UITextView *)textView {
    [self scrollViewToVisibalWithView:textView];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag-kCellSubViewTagStart inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)scrollViewToVisibalWithView:(id)view {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^(){
        CGRect cursorRect = [view caretRectForPosition:[view selectedTextRange].start];
        cursorRect = [self.tableView convertRect:cursorRect fromView:view];
        if (![self visibalRect:cursorRect]) {
            cursorRect.size.height += 18;
            [self.tableView scrollRectToVisible:cursorRect animated:YES];
        }
    });
}

- (BOOL)visibalRect:(CGRect)rect {
    CGRect visibalRect = CGRectZero;
    visibalRect.origin = self.tableView.contentOffset;
    visibalRect.size = CGSizeMake(self.tableView.bounds.size.width, self.tableView.bounds.size.height-self.tableView.contentInset.bottom);
    return CGRectContainsRect(visibalRect, rect);
}

//- (void)textViewDidChange:(UITextView *)textView {
//    
//}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self.view endEditing:YES];
//}

- (void)keyboardChanged1:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSString *durationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:[durationValue floatValue] delay:0.0 options:(7<<16) animations:^{
        if ([[notification name] isEqualToString:UIKeyboardWillShowNotification]) {
            
            weakself.tableView.contentInset = UIEdgeInsetsMake(64, 0, keyboardSize.height, 0);
        }
        else if ([[notification name] isEqualToString:UIKeyboardWillHideNotification]) {
            weakself.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        }
    } completion:^(BOOL finished){
        
    }];
}

#pragma mark - test

- (void) displayChange{
    if (displayFlag) {
        [self drawDisplayView];
        displayFlag = NO;
    }else{
        [self drawIndisplayView];
        displayFlag = NO;
    }
}

- (void) initDisplay{
    if ([self needsDisplayFlag]) {
        [self drawIndisplayView];
    }
}

- (void) drawIndisplayView{
    [self.displayBtn setTitle:@"展开" forState:UIControlStateNormal];
    CGRect frame = self.rightAccessView.frame;
    frame.size.height = kFontOfText*kNeedDisplayLineCountsMin;
    self.rightAccessView.frame = frame;
    displayFlag = YES;
    [self.rightAccessView setNeedsDisplay];
}

- (void) drawDisplayView{
    [self.displayBtn setTitle:@"收起" forState:UIControlStateNormal];
    CGRect frame = self.rightAccessView.frame;
    CGSize size = [self.rightAccessView.midDisplayLabel sizeThatFits:CGSizeMake(self.rightAccessView.midDisplayLabel.frame.size.width, MAXFLOAT)];
    frame.size = size;
    self.rightAccessView.frame = frame;
    displayFlag = NO;
    [self.rightAccessView setNeedsDisplay];
}

- (BOOL) needsDisplayFlag{
    CGSize size = self.rightAccessView.midDisplayLabel.frame.size;
    if (size.height > kFontOfText*kNeedDisplayLineCountsMin) {
        return YES;
    }
    return NO;
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self initDisplay];
}

- (void) textChange{
    CGRect frame = self.rightTextViewMode.rightTextView.frame;

//    第一种
//    frame.size.height = self.rightTextViewMode.rightTextView.contentSize.height;

//    第二种
//    frame.size.height = [ViewHelper calculateHeightWithTextView:self.rightTextViewMode.rightTextView withTextFont:[UIFont systemFontOfSize:kFontOfText]];
//    if ((kInputViewTop+kInputViewBottom+kFontOfText*kTextViewDefaultLineCount) < frame.size.height) {
//        self.rightTextViewMode.rightTextView.frame = frame;
//    }
//    if (frame.size.height >= SCREEN_HEIGHT-kStatusBarHeight-self.keyboardFrame.size.height) {
//        self.rightTextViewMode.rightTextView.frame = frame;
//    }
    [self.rightTextViewMode setRightTextViewRealHeight];
    if ((kInputViewTop+kInputViewBottom+kFontOfText*kTextViewDefaultLineCount) > frame.size.height) {
        CGRect myFrame = self.rightTextViewMode.frame;
        myFrame.size.height = kInputViewTop+kInputViewBottom+kFontOfText*kTextViewDefaultLineCount;
        self.rightTextViewMode.frame = myFrame;
    }
    if (frame.size.height >= SCREEN_HEIGHT-kStatusBarHeight-self.keyboardFrame.size.height) {
        CGRect myFrame = self.rightTextViewMode.frame;
        myFrame.size.height = SCREEN_HEIGHT-kStatusBarHeight-self.keyboardFrame.size.height;
        self.rightTextViewMode.frame = myFrame;
    }
    
}

- (void) keyboardChanged:(NSNotification *)noti{
    self.keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
}


- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [self.view releaseResource];
    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
