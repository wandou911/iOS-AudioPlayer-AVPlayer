//
//  DownLoadRequest.h
//  MP3Player
//
//  Created by wandou on 2017/9/4.
//  Copyright © 2017年 wandou. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <Foundation/Foundation.h>

#define ZFileDownloadPath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"MyDownloadFile.mp3"]

@interface DownLoadRequest : NSObject
/**
 *  URL   下载链接
 *  Path  下载存放路径,如果程序退出,下次传入的路径和上一次一样,可以继续断点下载
 */
- (instancetype)initWithURL:(NSString *)URL Path:(NSString *)path;

/**
 * 下载回调
 */
-(void)BegindownProgress:(void (^)(long long totalReceivedContentLength, long long totalContentLength))progress Succeed:(void(^)(NSString * URL, NSString * path))succeed Failure:(void(^)())failure;

/**
 * 取消下载
 */
-(void)cancelLoad;

/**
 * 开始下载
 */
-(void)startLoad;

//-(void)deleteAllFile;

@end
