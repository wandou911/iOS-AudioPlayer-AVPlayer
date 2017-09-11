//
//  MusicPlayerController.m
//  MP3Player
//
//  Created by wandou on 2017/9/4.
//  Copyright © 2017年 wandou. All rights reserved.
//

#import "MusicPlayerController.h"

@interface MusicPlayerController ()

@end

@implementation MusicPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.1 AVAudioPlayer 直接播放
    //[self audioPlay];
    //1.2 AVAudioPlayer下载后播放
    [self prepareForDownload];
    //2 AVPlayer播放
    //[self avPlay];
    //[self prepareForDownload];
    
}

//1. AVAudioPlayer播放本地音频文件

- (void) audioPlay{
    //获取文件名
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"あっちゅ～ま青春!" ofType:@"mp3"];
    //文件名转换成url格式
    NSURL *url = [NSURL fileURLWithPath:filePath];
    //记得AVAudioPlayer对象设置成全局变量才可以播放
    _audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _audio.delegate = self;
    _audio.enableRate = YES;
    [_audio prepareToPlay];
    [_audio play];
    
}


//2. AVPlayer播放音频文件

- (void)avPlay
{
    if (_avPlayer == nil) {
        // (1)获取文件（远程/本地）
        NSString *strURL = @"http://media.youban.com/gsmp3/mqualityt300/134180706730980.mp3";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"あっちゅ～ま青春!" ofType:@"mp3"];
        // (2)把音频文件转化成url格式
        NSURL *url = [NSURL URLWithString:strURL];
        NSURL *url2 = [NSURL fileURLWithPath:path];
        // (3)使用playerItem获取视频的信息，当前播放时间，总时间等
        AVPlayerItem * songItem = [AVPlayerItem playerItemWithURL:url2];
        // (3)初始化音频类 并且添加播放文件
        
         _avPlayer = [AVPlayer playerWithPlayerItem:songItem];
        // (4) 设置初始音量大小 默认1，取值范围 0~1
        _avPlayer.volume = 1.0;
        [_avPlayer play];
    }
    
    
}

//设置播放速率
- (IBAction)playRate:(UIButton *)sender {
    _audio.rate = 0.5f;
    _avPlayer.rate = 0.5f;
}
- (IBAction)playRate2:(UIButton *)sender {
    _audio.rate = 1.5f;
     _avPlayer.rate = 1.5f;
}
- (IBAction)playRate3:(UIButton *)sender {
    _audio.rate = 2.0f;
     _avPlayer.rate = 2.0f;
}
//正常速率
- (IBAction)playRate4:(UIButton *)sender {
    _audio.rate = 1.0f;
    _avPlayer.rate = 1.0f;
}




- (void)prepareForDownload
{
    //下面是使用方法
    //1.下载之前清一下缓存,并把播放器置为空；
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:ZFileDownloadPath]) {
        // 删除沙盒中所有资源
        [fileManager removeItemAtPath:ZFileDownloadPath error:nil];
    }
    
    self.audio = nil;
    
    //2.下载文件
    NSString *url = @"http://media.youban.com/gsmp3/mqualityt300/134180706730980.mp3";
    [self download:url];
}


//演示2
-(void)download:(NSString *)urlStr
{
    self.down = nil;
    __weak typeof (self)weakself = self;
    self.down = [[DownLoadRequest alloc]initWithURL:urlStr Path:ZFileDownloadPath];
    [self.down BegindownProgress:^(long long totalReceivedContentLength, long long totalContentLength) {} Succeed:^(NSString *URL, NSString *path) {
        NSLog(@"%@",path);
        NSURL *url = [NSURL fileURLWithPath:path];
        
        weakself.audio = nil;
        weakself.audio = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        weakself.audio.enableRate = YES;
        [weakself.audio prepareToPlay];
        weakself.audio.numberOfLoops = 0;
        weakself.audio.delegate = weakself;
        weakself.audio.volume = 1;//
        weakself.audio.currentTime = 0;//可以指定从任意位置开始播放
        [weakself.audio play];
    } Failure:^{
        
        weakself.audio = nil;
        
    }];
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //播放结束时执行的动作
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
