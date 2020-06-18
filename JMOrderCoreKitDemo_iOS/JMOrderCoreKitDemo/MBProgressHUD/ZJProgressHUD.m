//
//  ZJProgressHUD.m
//  MeshLight
//
//  Created by lizhijian on 15/9/28.
//  Copyright © 2015年 Concox. All rights reserved.
//

#import "ZJProgressHUD.h"
#import "MBProgressHUD.h"

#ifndef kScreenHeight
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)   //屏幕高度
#endif
#ifndef kScreenWidth
#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)     //屏幕宽度
#endif

@interface ZJProgressHUD() <MBProgressHUDDelegate>

@property (nonatomic, strong) UIWindow *overlayWindow;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIView *subView;
@property (nonatomic, assign) BOOL isShowLan;

@end

@implementation ZJProgressHUD
static ZJProgressHUD *_sharedHUD; 

+ (instancetype)sharedHUD {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        _sharedHUD = [[ZJProgressHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return _sharedHUD;
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    self.overlayWindow.userInteractionEnabled = NO;
    if (self.isShowLan) {
        self.isShowLan = NO;
        if (_overlayWindow) {
            _overlayWindow.transform = CGAffineTransformIdentity;
        }
    } 
    
    [_overlayWindow resignKeyWindow];
    [_overlayWindow removeFromSuperview];
    _overlayWindow = nil;
}

#pragma mark _______________________________________________
#pragma mark 单例类--外部调用方法

+ (void)hideHUD
{
    [[ZJProgressHUD sharedHUD] hideHubWithAnmotion:YES];
}

+ (void)hideProcessHUD
{
    [[ZJProgressHUD sharedHUD] hideProcessHubWithAnmotion:YES];
}

+ (void)imHideHUD
{
    [[ZJProgressHUD sharedHUD] hideHubWithAnmotion:NO];
}

+ (void)imHideProcessHUD
{
    [[ZJProgressHUD sharedHUD] hideProcessHubWithAnmotion:NO];
}

+ (void)showMessage:(NSString *)title
{
    [ZJProgressHUD imHideHUD];     //先需要隐藏完成，才能显示下一个，否则Loading框可能大小有问题
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title mark:YES];
}

+ (void)showLanMessage:(NSString *)title
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title mark:YES];
}

+ (void)showMessageForNoMark:(NSString *)title
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title mark:NO];
}

+ (void)showLanMessageForNoMark:(NSString *)title
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title mark:NO];
}

+ (void)showLoading
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:NSLocalizedString(@"Loading...", nil) mark:YES];
}

+ (void)showLanLoading
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:NSLocalizedString(@"Loading...", nil) mark:YES];
}

+ (void)showLoadingForNoMark
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:NSLocalizedString(@"Loading...", nil) mark:NO];
}

+ (void)showLanLoadingForNoMark
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:NSLocalizedString(@"Loading...", nil) mark:NO];
}

+ (void)showSetting
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:NSLocalizedString(@"Setting...", nil) mark:YES];
}

+ (void)showLanSetting
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:NSLocalizedString(@"Setting...", nil) mark:YES];
}

+ (void)showSettingForNoMark
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:NSLocalizedString(@"Setting...", nil) mark:NO];
}

+ (void)showLanSettingForNoMark
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:NSLocalizedString(@"Setting...", nil) mark:NO];
}

+ (void)showSubmitting
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:NSLocalizedString(@"submitting...", nil) mark:YES];
}

+ (void)showLanSubmitting
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:NSLocalizedString(@"submitting...", nil) mark:YES];
}

+ (void)showSubmittingForNoMark
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:NSLocalizedString(@"submitting...", nil) mark:NO];
}

+ (void)showLanSubmittingForNoMark
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:NSLocalizedString(@"submitting...", nil) mark:NO];
}

+ (void)showStatusWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:0 mark:YES view:nil yOffset:0];
}

+ (void)showLanStatusWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:0 mark:YES view:nil yOffset:0];
}

+ (void)showStatusWithTitle:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:0 mark:YES view:nil yOffset:yOffset];
}

+ (void)showStatusWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration view:(UIView *)view
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:0 mark:NO view:view yOffset:0];
}

+ (void)showLanStatusWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration view:(UIView *)view
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:0 mark:NO view:view yOffset:0];
}

+ (void)showStatusWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration view:(UIView *)view yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:0 mark:NO view:view yOffset:0];
}

+ (void)showSuccessWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:1 mark:YES view:nil yOffset:0];
}

+ (void)showLanSuccessWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:1 mark:YES view:nil yOffset:0];
}

+ (void)showSuccessWithTitle:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:1 mark:YES view:nil yOffset:yOffset];
}

+ (void)showSuccessWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:1 mark:NO view:nil yOffset:0];
}

+ (void)showLanSuccessWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:1 mark:NO view:nil yOffset:0];
}

+ (void)showSuccessWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:1 mark:NO view:nil yOffset:yOffset];
}

+ (void)showLanSuccessWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:1 mark:NO view:nil yOffset:yOffset];
}

+ (void)showErrorWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:2 mark:YES view:nil yOffset:0];
}

+ (void)showErrorWithTitle:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:2 mark:YES view:nil yOffset:yOffset];
}

+ (void)showLanErrorWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:2 mark:NO view:nil yOffset:0];
}

+ (void)showErrorWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:2 mark:NO view:nil yOffset:0];
}

+ (void)showLanErrorWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showLan];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:2 mark:NO view:nil yOffset:0];
}

+ (void)showErrorWithTitleForNoMark:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset
{
    [ZJProgressHUD imHideHUD];
    [[ZJProgressHUD sharedHUD] showHubMessageWithTitle:title duration:duration state:2 mark:NO view:nil yOffset:yOffset];
}

+ (ZJProgressHUD *)showAnnularHubWithWithTitle:(NSString *)title view:(UIView *)view
{
    [ZJProgressHUD imHideProcessHUD];
    MBProgressHUD *hub = [[ZJProgressHUD sharedHUD] showAnnularHubWithWithTitle:title mark:NO view:view];
    if (hub) {
        return [ZJProgressHUD sharedHUD];
    }
    return nil;
}

#pragma mark _______________________________________________
#pragma mark PrivateAPI

- (void)setProgress:(CGFloat)progress
{
    if (self.hud && self.hud.mode == MBProgressHUDModeAnnularDeterminate) {
        self.hud.progress = progress;
    }
}

#pragma mark _______________________________________________
#pragma mark 单例类--内部使用方法

- (UIWindow *)overlayWindow
{
    if(!_overlayWindow) {
        if (@available(iOS 13.0, *)) {
               UIScene *Scene = [[UIApplication sharedApplication].connectedScenes allObjects].firstObject;
               if (Scene) {
                   _overlayWindow = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)Scene];
                   _overlayWindow.frame = _overlayWindow.coordinateSpace.bounds;
               }
        } else {
            _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        }
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
								| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _overlayWindow.backgroundColor = [UIColor clearColor];
        _overlayWindow.userInteractionEnabled = NO;
    }
    return _overlayWindow;
}

- (void)hideHubWithAnmotion:(BOOL)anmotion
{
    self.hud.delegate = anmotion?self:nil;
    self.overlayWindow.userInteractionEnabled = NO;
    [MBProgressHUD hideHUDForView:self animated:anmotion];
}

- (void)hideProcessHubWithAnmotion:(BOOL)anmotion
{
    self.hud.delegate = anmotion?self:nil;
    self.overlayWindow.userInteractionEnabled = NO;
    if (self.subView) {
        [MBProgressHUD hideHUDForView:self.subView animated:anmotion];
        self.subView = nil;
    }
}

- (void)showHubMessageWithTitle:(NSString *)string mark:(BOOL)isAdd
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    [self.overlayWindow addSubview:self];
    [self.overlayWindow makeKeyAndVisible];
    if (self.isShowLan) {
        self.overlayWindow.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    self.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
    
    // 快速显示一个提示信息
    _hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    self.hud.labelFont = [UIFont systemFontOfSize:16];
    self.hud.labelText = string;
    self.hud.delegate = nil;
    // 隐藏时候从父控件中移除
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.dimBackground = NO;   // YES代表需要蒙版效果
    if (isAdd) {
        self.overlayWindow.userInteractionEnabled = YES;
    } else {
        self.overlayWindow.userInteractionEnabled = NO;
    }
}

- (void)showHubMessageWithTitle:(NSString *)title duration:(NSTimeInterval)duration state:(NSInteger)suState mark:(BOOL)isAdd view:(UIView *)view yOffset:(CGFloat)yOffset
{
    if (self.superview) {
        [self removeFromSuperview];
    }
    if (view) {
        [view addSubview:self];
        if (self.isShowLan) {
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        self.center = CGPointMake(kScreenHeight/2.0, kScreenWidth/2.0);
    } else {
        [self.overlayWindow addSubview:self];
        [self.overlayWindow makeKeyAndVisible];
        if (self.isShowLan) {
            self.overlayWindow.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        self.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
    }
    
    // 快速显示一个提示信息
    _hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    if (suState == 1) {
        self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ZJHud_success"]];
    } else if (suState == 2) {
        self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ZJHud_error"]];
    }
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.labelFont = [UIFont systemFontOfSize:16];
    self.hud.labelText = title;
    self.hud.delegate = self;
    self.hud.yOffset = yOffset;
    [self.hud show:YES];
    [self.hud hide:YES afterDelay:duration];
    
    // 隐藏时候从父控件中移除
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.dimBackground = NO;   // YES代表需要蒙版效果
    if (isAdd) {
        self.overlayWindow.userInteractionEnabled = YES;
    } else {
        self.overlayWindow.userInteractionEnabled = NO;
    }
}

- (MBProgressHUD *)showAnnularHubWithWithTitle:(NSString *)title mark:(BOOL)isAdd view:(UIView *)view
{
    if(self.superview) {
        [self removeFromSuperview];
    }
    if (view) {
        self.subView = view;
        _hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    } else {
        [self.overlayWindow addSubview:self];
        [self.overlayWindow makeKeyAndVisible];
        if (self.isShowLan) {
            self.overlayWindow.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        self.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
        _hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    }
    
    self.hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelFont = [UIFont systemFontOfSize:14];
    self.hud.labelText = title;
    self.hud.progress = 0;
    self.hud.color = [UIColor clearColor];
    self.hud.delegate = self;
    
    // 隐藏时候从父控件中移除
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.dimBackground = NO;   // YES代表需要蒙版效果
    if (isAdd) {
        self.overlayWindow.userInteractionEnabled = YES;
    } else {
        self.overlayWindow.userInteractionEnabled = NO;
    }
    return _hud;
}

- (void)showLan
{
    _isShowLan = YES;
}

@end
