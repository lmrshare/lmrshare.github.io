---
layout: post
title: "整理自为知笔记的做Rearch和实习的一些日常笔记(2的代码补充)"
date: 2015-06-15
description: "Common Sense、Internship Experience(不对外开放)"
tag: Bundle
---

### Engine 中的数据类型，结构体，类:

`VoiceEngineImpl`中的各类型：

```
enum enAudioCodecType
{  ENGIEN_AUDIO_CODEC_ISAC = 0,
    ENGINE_AUDIO_CODEC_AMR  = 1,
    ENGINE_AUDIO_CODEC_SILK_NB = 2,
    ENGINE_AUDIO_CODEC_SILK_WB = 3,
    ENGINE_AUDIO_CODEC_NULL
}；//说明：这是编解码器类型
enum XVE_NetType
{  X_ENetNULL = 0,
    X_ENet2G =1,
    X_ENetNotWIFI = 2,
    X_ENet3G =3,
    X_ENetWIFI = 4
};//说明：网络类型。
enum enAudioDeviceMode
{  ENGINE_AUDIO_DEVICE_WORKMODE_DEFAULT=0,
    ENGIEN_AUDIO_DEVICE_WORKMODE_NORMAL = 1,
    ENGINE_AUDIO_DEVICE_WORKMODE_VOICE_CALL  = 2
};//音频设备工作模式

typedef struct _ChannelInfo
{
    int m_nChannelID;//通道的唯一标识
    bool mInit;//用于判断通道是否已经被初始化了
    bool mIsSend;//false表示没有进行音频编码和发包，然后可以做一些编码和发包的工作，然后将其设置成true
    bool mIsPlay;//false表示音频还没有进行播放，然后可以做播放相关的操作，然后将其设置成true
    int  m_nNetworkType;//网络类型，由XVE_NetType enum设置
    int  m_nACodecType;//编解码器类型，由enAudioCodecType设置
    int  m_nADeviceWorkMode;//音频设备模式，由enAudioDeviceMode设置
    //TransportChannelProxy* m_pNetWork;
}stChannelInfo;

//通道信息

```

这是接入点类型:

```
typedef enum tagAccessPointType
{
    AP_UNKNOWN = 0x0,		/**< Unknown */
    AP_WIFI   = 0x1,		/**< wifi/internet */
    AP_CMWAP = 0x2,			/**< cmwap */
    AP_CMNET = 0x3,			/**< cmnet */
    AP_UNIWAP = 0x4,		/**< uniwap */
    AP_UNINET = 0x5,		/**< uninet */
    AP_CTWAP = 0x6,			/**< ctwap */
    AP_CTNET = 0x7,			/**< ctnet */
    AP_3GWAP = 0x8,			/**< 3gwap */
    AP_3GNET = 0x9,			/**< 3gnet */
}EmAccessPoint;

enum tag_GIPS_STATUS
	{
    Xve_Status_Not_Initialize = 0,
    Xve_Status_Initialized,
    Xve_Status_Start,
    Xve_Status_Mute,
    Xve_Status_Stop
	};
enum tagPacketType {
	RTP_Packet = 1,
	RTCP_Packet = 2
	};//音频包类型
enum  XVE_WORK_MODE
{
   XWorkMode_P2P	= 0,	//VOIP
   XWorkMode_TALK	= 1,	//TALK
   XWorkMode_CONFERENCE      = 2,//Multi Persion Audio
   XWorkMode_GAME = 8,
   XWorkMode_BUTT = 255
}//工作模式
enum XVE_Data_Type
{
    XVE_EDataType_Video=0,
    XVE_EDataType_Audio=1,
    XVE_EDataType_ARtcp=2,
    XVE_EDataType_P2S  =3,
    XVE_EDataType_S2P  =4,
    XVE_EDataType_S2P_VAD_NOTIFY = 10
};//数据类型
typedef enum
{
	X_AMR_NB   = 0,   //112
	X_AMR_WB   = X_AMR_NB+1 ,
	X_ISACFIX  = X_AMR_WB+1 ,  //179
	X_SPEEX_NB = X_ISACFIX+1 ,
	X_SPEEX_WB = X_SPEEX_NB+1,
	X_ILBC     = X_SPEEX_WB+1,
    X_SILK_NB  = X_ILBC+1,
    X_SILK_WB  = X_SILK_NB+1,
	X_RED      = X_SILK_WB+1,   //117
	X_CN       = X_RED+1,
	X_CN_WB    = X_CN+1,
	X_BUTT     = X_CN_WB+1

}XVE_CODEC;//编解码类型
enum XVE_NetType
{
    X_ENetNULL = 0,
    X_ENet2G =1,
    X_ENetNotWIFI = 2,
    X_ENet3G =3,
    X_ENetWIFI = 4
};//网络类型
typedef enum
{
  AMR_NB_PT = 112,
  AMR_WB_PT = 120,
  ISACFIX_PT = 103,
  ILBC_PT = 102,
  RED_PT = 117,
  SPEEX_NB_PT=98,
  SPEEX_WB_PT=99,
  CN_PT = 13,
  CN_WB_PT = 105,
  SILK_NB_PT = 121,
  SILK_WB_PT = 122,
  BUTT_PT = -1
  
}XVE_PAYLOAD;//编解码负载类型
typedef enum 
{

 RTP_STAND_MODE = 0,     //stand rtp foramt
 RTP_COMPRESS_MODE = 1,  //compressed rtp format
 RTP_UNKNOWN=2

}rtp_packe_mode;//rtp模式
enum XVE_NSmodes                   // type of Noise Suppression
{
	NS_UNCHANGED = 0,				// previously set mode
    NS_DEFAULT,                     // platform default
	NS_CONFERENCE,					// conferencing default
    NS_LOW_SUPPRESSION,             // lowest suppression
    NS_MODERATE_SUPPRESSION,
    NS_HIGH_SUPPRESSION,
    NS_VERY_HIGH_SUPPRESSION,       // highest suppression
};//
-----------------------------------class------------------
class VoiceEngineImpl :public XVE_Transport,public INetNotifier//,public IVoiceEngineBase
{
enum tag_GIPS_STATUS
enum tagPacketType
}

```

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/) 
