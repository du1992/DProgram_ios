//
//  DWaveView.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/1.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^JSWaveBlock)(CGFloat currentY);

@interface DWaveView : DView
/**
 *  浪弯曲度
 */
@property (nonatomic, assign) CGFloat waveCurvature;
/**
 *  浪速
 */
@property (nonatomic, assign) CGFloat waveSpeed;
/**
 *  浪高
 */
@property (nonatomic, assign) CGFloat waveHeight;
/**
 *  实浪颜色
 */
@property (nonatomic, strong) UIColor *realWaveColor;
/**
 *  遮罩浪颜色
 */
@property (nonatomic, strong) UIColor *maskWaveColor;

@property (nonatomic, copy) JSWaveBlock waveBlock;

- (void)stopWaveAnimation;

- (void)startWaveAnimation;

@end
NS_ASSUME_NONNULL_END
