//
//  JMOrderCamera.h
//  JimiOrderCoreKitDemo_iOS
//
//  Created by lzj<lizhijian_21@163.com> on 2020/4/1.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import <JMMonitorView/JMMonitor.h>
#import <JMSmartMediaPlayer/JMError.h>
#import <JMSmartMediaPlayer/JMMediaPlayerEnum.h>
#import <JMSmartMediaPlayer/JMSmartMediaPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMOrderCamera : NSObject

@property (nonatomic,weak) id<JMMediaNetworkPlayerDelegate> _Nullable delegate;
@property (nonatomic,readonly) NSString *imei;                 //设备IMEI
@property (nonatomic,readonly) NSInteger channel;                 //Camera摄像头通道号(标识)
@property (nonatomic,readonly) BOOL supportMulCamera;   //是否支持多路摄像头
@property (nonatomic,assign) BOOL mute;                 //静音设置
@property (nonatomic,assign) BOOL sniffStreamEnable;

/// 初始化Camera
/// @param imei 设备IMEI
/// @param channel Camera摄像头通道号(标识)
- (instancetype)initWithIMEI:(NSString *)imei channel:(NSInteger)channel;

/// 加载显示视图
/// @param monitor 显示视图
- (void)attachMonitor:(JMMonitor *_Nonnull)monitor;

/// 释放显示视图
- (void)deattachMonitor;

/// 开始直播
/// @param handler 回调
- (void)startPlay:(void (^ _Nonnull)(BOOL success, JMError *_Nullable error))handler;

/// 停止直播、历史视频播放、录像等
- (void)stopPlay;

/// 查询历史视频列表
/// @param startTime 开始时间(UTC,秒)
/// @param endTime 结束时间(UTC,秒)
/// @param handler 回调
- (void)playbackQueryList:(NSUInteger)startTime endTime:(NSUInteger)endTime handler:(void (^_Nonnull)(BOOL success, NSArray *fileList, JMError *error))handler;

/// 历史视频回放
/// @param fileArray 文件名称列表
/// @param bAppend 是否追加播放
/// @param handler 回调
- (void)playback:(NSArray *)fileArray append:(BOOL)bAppend handler:(void (^_Nonnull)(BOOL success, NSInteger statusCode, NSString *fileName, JMError *error))handler;

/// 开始录像
/// @param fileName 保存的录像路径(绝对路径,以.mp4结尾)
/// @param handler 回调
- (void)startRecord:(NSString *)fileName handler:(void (^_Nonnull)(enum JM_MEDIA_RECORD_STATUS status, NSString *filePath, JMError *_Nullable error))handler;

/// 停止录像
- (void)stopRecord;

/// 是否正在录像
- (BOOL)isRecording;

/// 截图
- (UIImage *)snapshot;

/// 开始对讲
/// @param handler 回调
- (void)startTalk:(void (^ _Nonnull)(enum JM_MEDIA_TALK_STATUS status, JMError *_Nullable error))handler;

/// 停止对讲
- (void)stopTalk;

/// 是否正在对讲
- (BOOL)isTalking;

/// 切换摄像头
/// @param handler 回调
- (void)switchCamera:(void (^ _Nonnull)(BOOL success, JMError *_Nullable error))handler;

/// 发送自定义消息
/// @param msg 消息内容
/// @param handler 回调
- (void)sendCustomMsg:(NSString *)msg handler:(void (^ _Nonnull)(BOOL success, NSString *data, JMError *_Nullable error))handler;

/// 停止所有功能
- (void)stop;

@end


NS_ASSUME_NONNULL_END
