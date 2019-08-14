//
//  NSTimer+addition.h
//  TGWebViewController
//
//  Created by 赵群涛 on 2017/9/19.
//  Copyright © 2017年 QR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (addition)

/** 暂停时间 */
- (void)tg_pauseTime;
/** 获取内容所在当前时间 */
- (void)tg_webPageTime;
/** 当前时间 time 秒后的时间 */
- (void)tg_webPageTimeWithTimeInterval:(NSTimeInterval)time;

@end
