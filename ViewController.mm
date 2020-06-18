//
//  ViewController.m
//  JimiTrackerOrder
//
//  Created by lzj<lizhijian_21@163.com> on 2019/12/2.
//  Copyright © 2019 Jimi. All rights reserved.
//

#import "ViewController.h"
#import <JMOrderCoreKit/JMOrderCoreKit.h>
#import <JMOrderCoreKit/JMOrderCamera.h>
#import <JMLog/JMLog.h>
#import "MBProgressHUD/ZJProgressHUD.h"
#import "CheckUpdateController.h"

@interface ViewController () <JMOrderCoreKitServerDelegate,JMLogDelegate>

@property (weak, nonatomic) IBOutlet JMMonitor *cameraMonitor1;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextField *secretTextField;
@property (weak, nonatomic) IBOutlet UITextField *imeiTextField;
@property (weak, nonatomic) IBOutlet UITextField *serverTextField;
@property (weak, nonatomic) IBOutlet UIButton *record1Btn;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *sdkInitBtn;
@property (weak, nonatomic) IBOutlet UITextField *playbackListTextField;

@property (nonatomic, strong) JMOrderCamera *pOrderCamera1;

@property (nonatomic, assign) BOOL supportMulCamera;
@property (nonatomic, strong) NSString *serverHostsStr;
@property (weak, nonatomic) IBOutlet UIButton *startPlay2;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self initOrderClientKit];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self deinitOrderClientKit];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cameraMonitor1.backgroundColor = [UIColor blackColor];
    [JMLog setDelegate:self];
    [self readTestInfo];

#if !TARGET_IPHONE_SIMULATOR
    [[CheckUpdateController sharedCheckUpdate] checkAppUpdate:YES block:nil];
#endif
}

- (void)initOrderClientKit
{
    if ([JMOrderCoreKit Initialize] == 0) {
        if (![self.serverTextField.text isEqualToString:@""]) {
            [JMOrderCoreKit configServer:self.serverTextField.text];
        }
        [JMOrderCoreKit configDeveloper:self.keyTextField.text secret:self.secretTextField.text userID:self.accountTextField.text];
        JMOrderCoreKit.shared.delegate = self;
        [JMOrderCoreKit.shared connect];

        self.pOrderCamera1 = [[JMOrderCamera alloc] initWithIMEI:self.imeiTextField.text channel:0];
        [self.pOrderCamera1 attachMonitor:_cameraMonitor1];
    }
}

- (void)deinitOrderClientKit
{
    if ([JMOrderCoreKit DeInitialize] == 0) {
        [self.pOrderCamera1 stop];
        [self.pOrderCamera1 deattachMonitor];
        JMOrderCoreKit.shared.delegate = nil;
    }
}

- (IBAction)clickedStartPlay1Btn:(UIButton *)sender {
    [self.pOrderCamera1 startPlay:^(BOOL success, JMError * _Nullable error) {
        NSLog(@"startPlay:%d error[%ld]:%@", success, (long)error.errCode, error.errMsg);
        [self showError:error];
    }];
}

- (IBAction)clickedStopPlay1Btn:(UIButton *)sender {
    [self.pOrderCamera1 stopPlay];
}

- (IBAction)clickedQueryPlaybackListBtn:(UIButton *)sender {
    [self.pOrderCamera1 playbackQueryList:0 endTime:0 handler:^(BOOL success, NSArray * _Nonnull fileList, JMError * _Nonnull error) {
        NSLog(@"playbackQueryList[%d]:%@", success, fileList);
        if (success) {
            NSString *str = fileList.firstObject;
            for (int i=1; i<fileList.count; i++) {
                str = [NSString stringWithFormat:@"%@,%@", str, [fileList objectAtIndex:i]];
            }
            if (str) {
                NSLog(@"%@", str);
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.playbackListTextField.text = str;
                });
            }
        } else {
            [self showError:error];
        }
    }];
}

- (IBAction)clickedPlayback1Btn:(UIButton *)sender {

    NSArray *array = nil;
    if (![self.playbackListTextField.text isEqualToString:@""]) {
        array = [self.playbackListTextField.text componentsSeparatedByString:@","];
    } else {
        array = [NSArray arrayWithObjects:@"2020_04_03_16_35_08_01.mp4", @"2020_04_03_16_36_08_01.mp4", @"2020_04_03_16_37_09_01.mp4", @"2020_04_03_16_38_09_01.mp4", @"2020_04_03_16_39_09_01.mp4", @"2020_04_03_16_40_10_01.mp4", nil];
    }
    [self.pOrderCamera1 playback:array append:YES handler:^(BOOL success, NSInteger status, NSString * _Nonnull fileName, JMError * _Nonnull error) {
        NSLog(@"playback:%d status:%ld fileName:%@ error[%ld]:%@", success, (long)status, fileName, (long)error.errCode, error.errMsg);
        [self showError:error];
    }];
}

- (IBAction)clickedRecord1Btn:(UIButton *)sender {
    if ([self.pOrderCamera1 isRecording]) {
        [sender setTitle:@"Record1" forState:UIControlStateNormal];

        [self.pOrderCamera1 stopRecord];
    } else {
        [sender setTitle:@"Recording1" forState:UIControlStateNormal];

        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *pathStr = [NSString stringWithFormat:@"%@/%ld.mp4", documentsPath, (long)[[NSDate date] timeIntervalSince1970]];
        [self.pOrderCamera1 startRecord:pathStr handler:^(JM_MEDIA_RECORD_STATUS status, NSString * _Nonnull filePath, JMError * _Nullable error) {
            if (status == JM_MEDIA_RECORD_STATUS_START) {
                NSLog(@"视频录制开始:%@", filePath);
                [self.record1Btn setTitle:@"StopRecord" forState:UIControlStateNormal];
            } else if (status == JM_MEDIA_RECORD_STATUS_COMPLETE) {
                [self.record1Btn setTitle:@"Record1" forState:UIControlStateNormal];
                if (filePath) {
                    UISaveVideoAtPathToSavedPhotosAlbum(filePath, self, @selector(video: didFinishSavingWithError: contextInfo:), nil);
                }
            } else {
                NSLog(@"视频录制失败:%@", filePath);
            }
            [self showError:error];
        }];
    }
}

- (IBAction)clickedSnapshot1Btn:(UIButton *)sender {
    UIImage *image = [self.pOrderCamera1 snapshot];
    if (image) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(video: didFinishSavingWithError: contextInfo:), nil);
    }
}

//切换摄像头
- (IBAction)clickedStartPlay2Btn:(UIButton *)sender {
    [self.pOrderCamera1 switchCamera:^(BOOL success, JMError * _Nullable error) {
        NSLog(@"switchCamera:%d error[%ld]:%@", success, (long)error.errCode, error.errMsg);
        [self showError:error];
    }];
}

- (IBAction)clickedStopPlay2Btn:(UIButton *)sender {
}

- (IBAction)clickedTalkBtn:(UIButton *)sender {
    if ([self.pOrderCamera1 isTalking]) {
        [self.pOrderCamera1 stopTalk];
        [sender setTitle:@"Talk" forState:UIControlStateNormal];
    } else {
        [self.pOrderCamera1 startTalk:^(JM_MEDIA_TALK_STATUS status, JMError * _Nullable error) {
            NSLog(@"didJMMediaNetworkTalkerWithStatus:%d error[%ld]:%@", status, (long)error.errCode, error.errMsg);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == JM_MEDIA_TALK_STATUS_START || status == JM_MEDIA_TALK_STATUS_PREPARE) {
                    [sender setTitle:@"Talking" forState:UIControlStateNormal];
                } else {
                    [sender setTitle:@"Talk" forState:UIControlStateNormal];
                }
            });
        }];
        [sender setTitle:@"Talking" forState:UIControlStateNormal];
    }
}

- (IBAction)clickedMuteBtn:(UIButton *)sender {
    self.pOrderCamera1.mute = !self.pOrderCamera1.mute;
}

- (IBAction)clickedSwitchServerBtn:(UIButton *)sender {
}

- (IBAction)clickedUninitBtn:(UIButton *)sender {

    if (JMOrderCoreKit.shared.delegate) {
        [self deinitOrderClientKit];
        [sender setTitle:@"Init" forState:UIControlStateNormal];
    } else {
        [self initOrderClientKit];
        [sender setTitle:@"UnInit" forState:UIControlStateNormal];
    }
}

#pragma mark -

//自动上升输入框高度
- (void)increaseTextField:(UITextField *)textField Y:(BOOL)isIncrease
{
    if (isIncrease) {
        CGFloat height = self.view.bounds.size.height - (textField.frame.origin.y+textField.bounds.size.height);
        CGFloat keyboardHeight = 300;       //假设所有键盘高度为271
        if (self.view.tag == 0 && height < keyboardHeight) {
            self.view.tag = 1;
            [UIView animateWithDuration:0.3 animations:^{
                self.view.center = CGPointMake(self.view.center.x, self.view.center.y-(keyboardHeight-height));
            } completion:^(BOOL finished){
            }];
        }
    } else {
        self.view.tag = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.view.center = CGPointMake(self.view.center.x, self.view.bounds.size.height/2.0);
        } completion:^(BOOL finished){
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self increaseTextField:textField Y:NO];

    if (textField == self.serverTextField) {
        self.serverTextField.enabled = NO;
        if (!self.serverTextField.text) {
//            self.serverTextField.text = [self.serverHostsArray objectAtIndex:0];
        }
    }

    [self saveTestInfo];

    return YES;
};

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self increaseTextField:textField Y:YES];

    [self deinitOrderClientKit];
    [self.sdkInitBtn setTitle:@"Init" forState:UIControlStateNormal];

    static BOOL bHint = true;
    if (bHint) {
        bHint = false;
        [ZJProgressHUD showStatusWithTitle:@"After editing, click the Init button to restart the service." duration:1.5];
    }
}

- (void)saveTestInfo
{
    //测试Demo使用，请勿用在其他项目
    NSMutableDictionary *testInfoDic = [NSMutableDictionary dictionary];
    [testInfoDic setObject:self.serverHostsStr forKey:@"kTestServerHostsAddr"];
    [testInfoDic setObject:self.serverTextField.text forKey:@"kTestServerAddr"];
    [testInfoDic setObject:self.keyTextField.text forKey:@"kTestKey"];
    [testInfoDic setObject:self.secretTextField.text forKey:@"kTestSecret"];
    [testInfoDic setObject:self.imeiTextField.text forKey:@"kTestIMEI"];
    [testInfoDic setObject:self.accountTextField.text forKey:@"kTestAccount"];
    [testInfoDic setObject:self.pwdTextField.text forKey:@"kTestPassword"];
    [testInfoDic setObject:self.playbackListTextField.text forKey:@"kTestPlaybackList"];
    [[NSUserDefaults standardUserDefaults] setObject:testInfoDic forKey:@"kTestInfoDic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)readTestInfo
{
    self.serverHostsStr = @"ws://36.133.0.208:8988/websocket";
    NSDictionary *testInfoDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"kTestInfoDic"];
    if (testInfoDic) {
        self.serverHostsStr = [testInfoDic objectForKey:@"kTestServerHostsAddr"];
        self.serverTextField.text = [testInfoDic objectForKey:@"kTestServerAddr"];
        self.keyTextField.text = [testInfoDic objectForKey:@"kTestKey"];
        self.secretTextField.text = [testInfoDic objectForKey:@"kTestSecret"];
        self.imeiTextField.text = [testInfoDic objectForKey:@"kTestIMEI"];
        self.accountTextField.text = [testInfoDic objectForKey:@"kTestAccount"];
        self.pwdTextField.text = [testInfoDic objectForKey:@"kTestPassword"];
        self.playbackListTextField.text = [testInfoDic objectForKey:@"kTestPlaybackList"];
    }

//    self.accountTextField.text = @"172";
//    self.imeiTextField.text = @"353376110005078";
//    self.serverTextField.text = @"ws://36.133.0.208:8888/websocket";
}

#pragma mark -

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        NSLog(@"保存到相册成功");
        [ZJProgressHUD showSuccessWithTitle:@"Album saved successfully" duration:1.5f];
    } else {
        [ZJProgressHUD showSuccessWithTitle:@"Failed to save album" duration:1.5f];
        NSLog(@"保存到相册失败");
    }
}

- (void)showError:(JMError *)error
{
    if (error && error.errCode != 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD showErrorWithTitle:[NSString stringWithFormat:@"[%ld]%@", (long)error.errCode, error.errMsg?@"Operation failed!":error.errMsg] duration:3.0];
        });
    }
}

#pragma mark - JMLogDelegate

- (void)didReceiveLogString:(NSString *)logStr
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@", logStr);
        if (self.logTextView.text.length > 2048) {
            self.logTextView.text = [NSString stringWithFormat:@"%@%@", [self.logTextView.text substringFromIndex:1024], logStr];
        } else {
            self.logTextView.text = [NSString stringWithFormat:@"%@%@", self.logTextView.text, logStr];
        }
        [self.logTextView scrollRangeToVisible:NSMakeRange(self.logTextView.text.length, 1)];
    });
}

#pragma mark - JMOrderCoreKitServerDelegate

- (void)didJMOrderCoreKitWithError:(JMError *)error
{
    NSLog(@"didJMOrderCoreKitWithError:%ld error:%@", (long)error.errCode, error.errMsg);
    [self showError:error];
}

- (void)didJMOrderCoreKitConnectWithStatus:(JM_SERVER_CONNET_STATE)state
{
    NSLog(@"didJMOrderCoreKitConnectWithStatus:%d", state);
    if (state == JM_SERVER_CONNET_STATE_CONNECTED) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD showSuccessWithTitle:@"Server connected successfully" duration:1.5];
            [JMOrderCoreKit.shared GetVersion:self.imeiTextField.text handler:^(NSString * _Nonnull imei, BOOL success, NSString * _Nonnull version, BOOL supportMulCamera) {
                NSLog(@"GetVersion:%@ success:%d version:%@ supportMulCamera:%d", imei, success, version, supportMulCamera);
            }];
        });
    } else if (state >= JM_SERVER_CONNET_STATE_FAILED) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD showSuccessWithTitle:@"Failed to connect server!" duration:1.5];
        });
    }
}

- (void)didJMOrderCoreKitReceiveDeviceData:(NSString * _Nullable)imei data:(NSString *_Nullable)data
{
    NSLog(@"didJMOrderCoreKitReceiveDeviceData:%@ data:%@", imei, data);
}

@end
