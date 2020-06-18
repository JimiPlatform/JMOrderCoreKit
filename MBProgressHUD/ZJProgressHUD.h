//
//  ZJProgressHUD.h
//  MeshLight
//
//  Created by lizhijian on 15/9/28.
//  Copyright © 2015年 Concox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZJProgressHUD : UIView

@property (nonatomic,assign) CGFloat progress;

+ (void)hideHUD;
+ (void)hideProcessHUD;

+ (void)showMessage:(NSString *)title;      //带遮罩层提示Loading框
+ (void)showLanMessage:(NSString *)title;
+ (void)showMessageForNoMark:(NSString *)title;     //不带遮罩层提示Loading框
+ (void)showLanMessageForNoMark:(NSString *)title;
+ (void)showLoading;
+ (void)showLoadingForNoMark;
+ (void)showSetting;
+ (void)showSettingForNoMark;
+ (void)showSubmitting;
+ (void)showLanSubmitting;
+ (void)showSubmittingForNoMark;
+ (void)showLanSubmittingForNoMark;
+ (void)showStatusWithTitle:(NSString *)title duration:(NSTimeInterval)duration;
+ (void)showStatusWithTitle:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;
+ (void)showStatusWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration view:(UIView *)view;
+ (void)showStatusWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration view:(UIView *)view yOffset:(CGFloat)yOffset;

+ (void)showSuccessWithTitle:(NSString *)title duration:(NSTimeInterval)duration;
+ (void)showLanSuccessWithTitle:(NSString *)title duration:(NSTimeInterval)duration;
+ (void)showSuccessWithTitle:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;
+ (void)showSuccessWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration;
+ (void)showLanSuccessWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration;
+ (void)showSuccessWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;
+ (void)showErrorWithTitle:(NSString *)title duration:(NSTimeInterval)duration;
+ (void)showLanErrorWithTitle:(NSString *)title duration:(NSTimeInterval)duration;
+ (void)showErrorWithTitle:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;
+ (void)showErrorWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration;
+ (void)showLanErrorWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration;
+ (void)showErrorWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;
+ (ZJProgressHUD *)showAnnularHubWithWithTitle:(NSString *)title view:(UIView *)view;



@end
