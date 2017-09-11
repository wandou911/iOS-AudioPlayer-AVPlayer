//
//  MusicPlayerController.h
//  MP3Player
//
//  Created by wandou on 2017/9/4.
//  Copyright © 2017年 wandou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoadRequest.h"
#import <AVFoundation/AVFoundation.h>//要导入系统框架AVFoundation.framework


//加入代理 AVAudioPlayerDelegate
@interface MusicPlayerController : UIViewController<AVAudioPlayerDelegate,UIWebViewDelegate>

@property (strong, nonatomic) AVAudioPlayer * audio;//播放器
@property (strong, nonatomic) DownLoadRequest * down;//下载器
@property (strong, nonatomic) AVPlayer *avPlayer;

@end
