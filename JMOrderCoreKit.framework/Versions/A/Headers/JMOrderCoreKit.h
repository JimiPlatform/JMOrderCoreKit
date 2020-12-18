//
//  JMOrderCoreKit.h
//  JMOrderCoreKit
//
//  Created by lzj<lizhijian_21@163.com> on 2020/4/8.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMOrderCamera.h"
#import "JMOrderCoreKitEnum.h"
#import "JMErrno.h"
#import <JMSmartMediaPlayer/JMError.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JMOrderCoreKitServerDelegate;

@interface JMOrderCoreKit : NSObject

/// 初始化SDK
/// @return 0：成功，-2：已经初始化
+ (int)Initialize;

/// 释放SDK
/// @return 0：成功，-1：已经释放
+ (int)DeInitialize;

/// 配置开发者信息
/// @param sKey 开发者Key
/// @param sSecret 开发者Secret
/// @param sUserID 用户ID
+ (BOOL)configDeveloper:(NSString * _Nonnull)sKey secret:(NSString * _Nonnull)sSecret userID:(NSString * _Nonnull)sUserID;

/// 配置WebSocket服务器
/// @param sWebSocketUrl 服务器地址
/// @return false：url失败或未启动重新连接
+ (BOOL)configServer:(NSString *)sWebSocketUrl;

/// 配置单机版TCP服务
/// @param hosts 服务器地址
/// @param port 服务器端口
/// @return false：未启动重新连接
+ (BOOL)configTCPServer:(NSString *)hosts port:(NSInteger)port;

#pragma mark -

@property (nonatomic,weak) id<JMOrderCoreKitServerDelegate> _Nullable delegate;

+ (instancetype _Nullable)shared;

/// 启动服务
- (void)connect;

/// 关闭服务
- (void)disconnect;

/// 是否已连接
- (BOOL)IsConnected;

/// 获取设备的版本等信息
/// @param imei 设备imei
/// @param handler 获取版本信息，是否支持多路功能
- (BOOL)GetVersion:(NSString *)imei handler:(void (^ _Nonnull)(NSString *imei, BOOL success, NSString *version, BOOL supportMulCamera))handler;

/// 发送track指令
/// @param command 指令
- (void)sendTrackCommand:(NSString *)command;

@end

#pragma mark - JMOrderCoreKitServerDelegate

@protocol JMOrderCoreKitServerDelegate <NSObject>
@optional

/// 内部反馈的错误码
/// @param error 错误信息
- (void)didJMOrderCoreKitWithError:(JMError *_Nullable)error;

/// 服务器连接状态
/// @param state 连接状态，JM_SERVER_CONNET_STATE
- (void)didJMOrderCoreKitConnectWithStatus:(enum JM_SERVER_CONNET_STATE)state;

/// 网关透传设备发送的消息(即设备端自定义发送的信息)
/// @param data 具体数据内容(一般为字典)
- (void)didJMOrderCoreKitReceiveDeviceData:(NSString * _Nullable)imei data:(NSString *_Nullable)data;

@end

NS_ASSUME_NONNULL_END
