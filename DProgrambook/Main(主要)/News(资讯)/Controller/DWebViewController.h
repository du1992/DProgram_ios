//
//  DWebViewController.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/11.
//  Copyright © 2019 liujiliu. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "DViewController.h"
#import "DNewsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DWebProgressLayer : CAShapeLayer
/** 开始加载 */
- (void)tg_startLoad;

/** 完成加载 */
- (void)tg_finishedLoadWithError:(NSError *)error;

/** 关闭时间 */
- (void)tg_closeTimer;

- (void)tg_WebViewPathChanged:(CGFloat)estimatedProgress;



@end



@interface DWebViewController : DViewController

@property(nonatomic,strong) DNewsModel*newsModel;

@end



NS_ASSUME_NONNULL_END
