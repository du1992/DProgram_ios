//
//  NSTimer+addition.m
//  TGWebViewController
//
//  Created by 赵群涛 on 2017/9/19.
//  Copyright © 2017年 QR. All rights reserved.
//

#import "NSTimer+addition.h"

@implementation NSTimer (addition)

- (void)tg_pauseTime{
    //判断定时器是否有效
    if (!self.isValid)  {
        return;
    }
    //停止计时器
    [self  setFireDate:[NSDate distantFuture]];
}
- (void)tg_webPageTime{
    //判断定时器是否有效
    if (!self.isValid)  {
        return;
    }
    //返回当期时间
    [self setFireDate:[NSDate date]];
}
- (void)tg_webPageTimeWithTimeInterval:(NSTimeInterval)time{
    //判断定时器是否有效
    if (!self.isValid)  {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

@end
