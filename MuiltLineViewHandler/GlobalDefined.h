//
//  GlobalDefined.h
//  MuiltLineViewHandler
//
//  Created by tunsuy on 1/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#ifndef GlobalDefined_h
#define GlobalDefined_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kInputViewTop 10
#define kInputViewBottom 10
#define kInputViewHeightMin 56
#define kStatusBarHeight 74

#define kFontOfText 14.0

/*******************************
 *         表单各种距离配置       *
 *******************************/
#define kPublicPersonCellHeight             52.5            //<!-- 用户cell高度 -->
#define kPublicFormMinHeight                49              //<!-- 表单最小高度 --> （一般高度）
#define kPublicFormHeadHeight               70              //<!-- 右边有头像的表单高度 --> （一般高度）
#define kPublicFormPaddingLeft              15              //<!-- 左空隙大小 -->
#define kPublicFormPaddingRight             15              //<!-- 右空隙大小 -->
#define kPublicFormMargin                   15              //<!-- 表单间隔大小,即中间灰色部分 -->
#define kPublicFormItemTextFontLeft         17              //<!-- 左边文字大小 -->
#define kPublicFormLeftTextPaddingAfterImg  7.5              //<!-- 左边有图标，文字距离图标间距 -->
#define kPublicFormItemTextFontRight        17              //<!-- 右边文字大小 -->
#define kPublicFormItemTextFontTime         17              //<!-- 右边文字大小（时间） -->
#define kPublicFormRightLabelMaxWidth       (SCREEN_WIDTH-140)//<!-- 右边label最大宽度 -->
#define kPublicFormArrow                    19              //<!-- 右边图片-箭头大小 -->
#define kPublicFormLogoLeft                 25              //<!-- 左边图片-图标大小 -->
#define kPublicFormLogoRight                25              //<!-- 右边图片-图标大小 -->
#define kPublicFormRightImageMergeTop       10              //<!-- 右侧头像距离上下边距 -->
#define kPublicFormCheckWidth               24              //<!-- 右边勾的半径 -->

#define kPublicFormSwitchWidth             51              //<!-- 开关按钮宽 -->
#define kPublicFormSwitchHeight            30              //<!-- 开关按钮高 -->
#define kPublicFormArrowLeft                5               //<!-- (右边箭头左边距（不分文字或图片）) -->
#define kPublicFormFootViewBtnPadding       40              //<!-- 表尾按钮与最后一行的即间隙大小 -->

#define kPublicFormFootViewFontSize         kTableSectionFootViewFontSize
#define kPublicFormHeaderViewFontSize       kTableSectionHeaderViewFontSize

#define kTableSectionFootViewFontSize       13              //<!-- 每个section下部分说明字体的大小 -->
#define kTableSectionHeaderViewFontSize     15              //<!-- 每个section上部分说明字体的大小 -->

#define kTableSectionFootPadding            6.5               //<!-- section的footview与cell的间隙  -->
#define kPublicFormHeaderYellowHeight        40              //有黄色杠的表单Header高度
#define kCellArrowRightUnderIOS7            (!ISIOS7?10:0)  //ios7一下UITableViewStyleGrouped样式右箭头右间隙需要加10
#define kPublicFormTitleMergeTop            15              //多行文字距离cell顶部位置
#define kPublicFormTitleMergeBottom         15              //多行文字距离cell底部位置

#define kPublicFormTextViewHeight           93              //表单textView的高度
#define kPublicFormTextViewMaxLen           5000            //表单textView的最大长度

#endif /* GlobalDefined_h */
