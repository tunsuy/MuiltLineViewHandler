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

#define kRightTextViewModeToLeft 10
#define kRightTextViewModeToRight 10
#define kTextViewDefaultLineCount 3
#define kViewMargin 15
#define kAccessViewWidthMin 30

#define kNeedDisplayLineCountsMin 2

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

static BOOL displayFlag = NO;

@interface ViewController ()

@property (nonatomic, strong) RightTextView *rightTextViewMode;
@property (nonatomic) CGRect keyboardFrame;
@property (nonatomic, strong) RightAccessView *rightAccessView;
@property (nonatomic, strong) UIButton *displayBtn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.rightTextViewMode = [[RightTextView alloc] initWithFrame:CGRectMake(kRightTextViewModeToLeft, kStatusBarHeight, SCREEN_WIDTH-kRightTextViewModeToRight-kRightTextViewModeToLeft, kInputViewTop+kInputViewBottom+kFontOfText*kTextViewDefaultLineCount)];
    [self.rightTextViewMode setLeftLabelValueWithText:@"多行文本测试"];
    [self.rightTextViewMode setLeftLabelRealWidth];
    [self.view addSubview:self.rightTextViewMode];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"EFEFF4" alpha:1.0]];
    
    self.rightAccessView = [[RightAccessView alloc] initWithFrame:CGRectMake(kRightTextViewModeToLeft, self.rightTextViewMode.frame.origin.y+self.rightTextViewMode.frame.size.height+kViewMargin, SCREEN_WIDTH-kRightTextViewModeToLeft-kRightTextViewModeToRight, kAccessViewWidthMin)];
    [self.rightAccessView setLeftLabelValueWithText:@"展开收起"];
    self.rightAccessView.midDisplayLabel.text = @"公司公司的三国杀的归属感是的是的发生的是的发生的是的发生的颂德歌功伤感的歌SD敢达高SD敢达高东方闪电是打发士大夫是打发士大夫是是打发士大夫是打发士大夫所发生的是的发生的";
    [self.rightAccessView setLeftLabelRealWidth];
    [self.rightAccessView setMidLabelRealHeight];
    [self.view addSubview:self.rightAccessView];
    
    [self.rightAccessView.displayBtn addTarget:self action:@selector(displayChange) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillShowNotification object:nil];
    
}

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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
