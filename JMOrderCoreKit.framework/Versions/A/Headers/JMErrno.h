//
//  JMErrno.h
//  ConcoxVideoPlayer
//
//  Created by lzj<lizhijian_21@163.com> on 2018/7/18.
//  Copyright © 2018年 Jimi. All rights reserved.
//

#ifndef JMErrno_h
#define JMErrno_h

#define JM_ERR_NoERROR  0
#define JM_ERR_SDK_UNINITIALIED  -1         //SDK未初始化
#define JM_ERR_SDK_INITIALIED  -2           //SDK已初始化
#define JM_ERR_GATEWAY_HOSTS_INVALID  -3    //网关服务器地址无效
#define JM_ERR_LIVE_HOSTS_INVALID  -4       //推流服务器地址无效
#define JM_ERR_WEB_HOSTS_INVALID  -5        //Web服务器地址无效
#define JM_ERR_PROTOCOL_UNKNOW  -6          //协议号无法识别
#define JM_ERR_IMEI_INVALID -7              //IMEI无效
#define JM_ERR_APPID_INVALID  -8            //APPID无效
#define JM_ERR_PARAMETER_INVALID  -9        //参数无效
#define JM_ERR_SEND_DATA_NO_JSON  -10       //发送的数据不是Json格式
#define JM_ERR_RECV_DATA_NO_JSON  -11       //接收的数据不是Json格式
#define JM_ERR_RECV_SERVER_DATA_INVALID  -12       //接收服务器下发的数据无效

#define JM_ERR_PROTOCOL_TRACK_NO_REALIZED -30     //Tracker协议未实现
#define JM_ERR_PROTOCOL_LIVE_NO_REALIZED -31     //流媒体协议未实现
#define JM_ERR_CHANNEL_EXCEED_MAX -32     //直播协议通道号溢出最大值（0~15）


#define JM_ERR_LIVE_NOT_SUPPPORT_CAMERA  -10000        //不支持多路摄像头
#define JM_ERR_LIVE_CMD_CODE_NO_EXIST  -10001           //指令cmdCode缺失
#define JM_ERR_LIVE_CMD_CODE_INVALID  -10002            //无效指令cmdCode
#define JM_ERR_LIVE_CMD_CONTENT_INVALID  -10003        //无效指令内容
#define JM_ERR_LIVE_CHANNEL_EXCEED_MAX -10004     //直播协议通道号溢出最大值（0~15）
#define JM_ERR_LIVE_APPID_INVALID  -10005             //APPID参数无效
#define JM_ERR_LIVE_URL_INVALID  -10006          //URL无效
#define JM_ERR_LIVE_INIT_FAILED   -10007                //初始化失败
#define JM_ERR_LIVE_OPEN_FAILED  -10008            //打开URL失败
#define JM_ERR_LIVE_OPEN_TIMEOUT  -10009         //打开超时
#define JM_ERR_LIVE_ENCODE_PARA_INVALID  -10010          //音视频参数错误
#define JM_ERR_LIVE_TALK_INIT_FAILED  -10011       //对讲拉流失败
#define JM_ERR_LIVE_PROTOCOL_NO_DELEGATE -10012            //协议未代理
#define JM_ERR_LIVE_PARAMETER_INVALID  -10013   //参数无效
#define JM_ERR_LIVE_REQUEST_TIMEOUT -10014  //请求超时
#define JM_ERR_LIVE_SERVER_DISCONNECTED -10015  //与服务器断开连接

#define JM_ERR_LIVE_PLAYING_BACK  -10100       //正在进行回放，无法操作
#define JM_ERR_LIVE_TALK_TALKING  -10101            //有人正在对讲，无法操作
#define JM_ERR_LIVE_MUL_LIVA_PLAY  -10102      //正在进行多人直播，无法操作

#pragma mark -

#define JM_ERR_SERVER_TIME_OUT 225 // 请求超时
#define JM_ERR_SERVER_INVALID_PARAMS 226 // 指令参数错误
#define JM_ERR_SERVER_DEVICE_OFF_LINE 228 // 设备不在线
#define JM_ERR_SERVER_DEVICE_BUSY 252 // 设备忙
#define JM_ERR_SERVER_SERVICE_ERROR 404 // 未知错误
#define JM_ERR_SERVER_NOT_AUTHORIZED 503 // 登录过期
#define JM_ERR_SERVER_PARAM_ERROR 11001 // 参数错误
#define JM_ERR_SERVER_DEV_KEY_NOT_EXIST 12001 // 开发者KEY无效
#define JM_ERR_SERVER_UUID_NOT_MATCH 12002 // 开发者,设备不匹配
#define JM_ERR_SERVER_UUID_NOT_EXIST 12003  // 设备UUID无效
#define JM_ERR_SERVER_DEV_SECRET_NOT_MATCH 12004 // 开发者SECRET不匹配
#define JM_ERR_SERVER_USERID_NOT_EXIST 12011 // userId不存在
#define JM_ERR_SERVER_APPID_NOT_EXIST 12012 // appId不存在
#define JM_ERR_SERVER_APPTYPE_NOT_EXIST 12013 // appType不存在
#define JM_ERR_SERVER_IMEI_USER_VALID_ERR 12030 // 用户设备校验过程出错
#define JM_ERR_SERVER_NOT_SUPPORT_M3U8 1005 // 不支持M3U8格式
#define JM_ERR_SERVER_EXPIRED_TOKEN 1006 // 令牌过期
#define JM_ERR_SERVER_INVALID_TOKEN 1007 // 令牌无效
#define JM_ERR_SERVER_PARTIAL_IMPORT_FAILURE 1008 // 部分导入失败
#define JM_ERR_SERVER_INVALIDATE_SERVER 12006 // 非主节点不能操作

#endif /*JMErrno_h */

