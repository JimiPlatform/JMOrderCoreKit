//
//  JMOrderCoreKitEnum.h
//  JimiOrderClientKit
//
//  Created by lzj<lizhijian_21@163.com> on 2020/4/8.
//  Copyright © 2020 Jimi. All rights reserved.
//

#ifndef JimiOrderClientKitEnum_h
#define JimiOrderClientKitEnum_h

//服务器连接状态
enum JM_SERVER_CONNET_STATE {
    JM_SERVER_CONNET_STATE_NONE = 0,
    JM_SERVER_CONNET_STATE_CONNECTTING,       //正在连接
    JM_SERVER_CONNET_STATE_CONNECTED,         //已连接
    JM_SERVER_CONNET_STATE_FAILED,    //连接失败，包括连接服务器、登录服务器失败
    JM_SERVER_CONNET_STATE_DISCONNECTED,      //连接已断开，表示之前连接成功之后突然断开
};

//指令cmdCode码
enum JM_DEVICE_CAMERA_CMD {
    JM_CAMERA_CMD_NONE = 0,                 //未识别指令、无效指令
    JM_CAMERA_CMD_GET_SDK_INFO_REQ = 0x1,     //获取设备端SDK信息
    JM_CAMERA_CMD_GET_SDK_INFO_RESP = 0x2,    //响应设备端SDK信息
    JM_CAMERA_CMD_HEARTBEAT_REQ = 0x3,       //心跳指令
    JM_CAMERA_CMD_HEARTBEAT_RESP = 0x4,       //心跳指令回复
    JM_CAMERA_CMD_ONLINE_COUNT_REQ = 0x5,     //在线人数
    JM_CAMERA_CMD_ONLINE_COUNT_RESP = 0x6,     //在线人数

    JM_CAMERA_CMD_START_PLAY_REQ = 0x100,     //直播指令(请求)    //256
    JM_CAMERA_CMD_START_PLAY_RESP = 0x101,    //直播指令(响应)
    JM_CAMERA_CMD_STOP_PLAY_REQ = 0x102,      //停止播放指令(请求)  //258
    JM_CAMERA_CMD_STOP_PLAY_RESP = 0x103,     //停止播放指令(响应)
    JM_CAMERA_CMD_PLAYBACK_REQ = 0x104,       //回放指令(请求)    //260
    JM_CAMERA_CMD_PLAYBACK_RESP = 0x105,      //回放指令(响应)
    JM_CAMERA_CMD_START_TALK_REQ = 0x106,         //开始对讲        //262
    JM_CAMERA_CMD_START_TALK_RESP = 0x107,         //开始对讲(响应)
    JM_CAMERA_CMD_STOP_TALK_REQ = 0x108,          //停止对讲
    JM_CAMERA_CMD_STOP_TALK_RESP = 0x109,          //停止对讲(响应)
    JM_CAMERA_CMD_SWITCH_CAMERA_REQ = 0x10A,        //切换摄像头(请求)，多路摄像头无效 //266
    JM_CAMERA_CMD_SWITCH_CAMERA_RESP = 0x10B,       //切换摄像头(响应)，多路摄像头无效 267
    JM_CAMERA_CMD_CUSTOM_MESSAGE_REQ = 0x10C,        //自定义消息(与设备端通信)
    JM_CAMERA_CMD_CUSTOM_MESSAGE_RESP = 0x10D,
    JM_CAMERA_CMD_QUERY_PLAYBACK_LIST_REQ = 0x10E,        //获取设备视频列表
    JM_CAMERA_CMD_QUERY_PLAYBACK_LIST_RESP = 0x10F,

    JM_CAMERA_CMD_PLAYBACK_FILE_END = 0x1000,  // 单个回放文件结尾（设备主动上报）
    JM_CAMERA_CMD_PLAYBACK_ALL_END = 0x1001,   // 回放所有文件结束（设备主动上报）
    JM_CAMERA_CMD_REPORED_MESSAGE_DATA = 0x1002,   //主动上报的未知数据信息
};

#endif /* JimiOrderClientKitEnum_h */
