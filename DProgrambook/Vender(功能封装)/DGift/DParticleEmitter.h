//  DGiftListView.h
//  GetOn
//
//  Created by DUCHENGWEN on 2017/6/2.
//  Copyright © 2017年 Tonchema. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


@interface DParticle : NSObject
@property(nonatomic, strong)UIColor* color;
@property(nonatomic, assign)CGPoint point;

@property(nonatomic, strong)UIColor* customColor;
@property(nonatomic, assign)CGFloat randomPointRange; //[-n,n),n>=0

@property(nonatomic, assign)CGFloat delayTime;
@property(nonatomic, assign)CGFloat delayDuration;
@end


@class UIImage;
@class UIColor;

@protocol DEmitterLayerDelegate <NSObject>

-(void)onAnimEnd;

@end

@interface DEmitterLayer : CALayer
@property(nonatomic, assign)CGPoint beginPoint; //粒子出生位置，默认在左边顶上
@property(nonatomic, assign)BOOL ignoredBlack; //忽略黑色，白色当做透明处理，默认为NO，必须在设置image前面设置
@property(nonatomic, assign)BOOL ignoredWhite; //忽略白色，白色当做透明处理，默认为NO，必须在设置image前面设置
@property(nonatomic, strong)UIColor* customColor; //改变粒子的颜色，必须在设置image前面设置
@property(nonatomic, assign)CGFloat randomPointRange; //[-n,n),n>=0，必须在设置image前面设置
/**
 * 每行/列最大粒子数,设为0时，即每个像素一个粒子，必须在设置image前面设置
 * 建议当图片较大时，粒子较多时设置
 */
@property(nonatomic,assign)uint32_t maxParticleCount;
@property(nonatomic,strong)UIImage* image; //设置后就确定了所有的粒子，一些要改变粒子属性的，要在该值设置之前改
@property(nonatomic,weak)id<DEmitterLayerDelegate> emitterDelegate;

-(void)restart;
@end






@interface DParticleEmitter : NSObject




/**************************************粒子*****************************************/
@property (nonatomic, copy) NSArray<CAEmitterCell *> *emitterCells;


/**
 飘落粒子效果
 @param emitterPosition 发射位置
 @param emitterSize     发射源的尺寸
 @param view            添加到的View
 @return                mySelf
 */
- (instancetype)addEmitterLayerPosition:(CGPoint)emitterPosition emitterSize:(CGSize)emitterSize view:(UIView *)view;

/**
 烟花粒子效果(弃用)
 @param view            添加到的View

 */
- (void)makeFireworksDisplay:(UIView*)view;
/**
 烟花粒子效果
 @param view            添加到的View
 
 */
- (void)makeFireworksDisplays:(UIView*)view;

/**
上浮粒子效果
 @param view            添加到的View
 */
- (void)addEmitterLayerFloating:(UIView*)view;

/**
 火焰
 @param view            添加到的View
 */
- (void)flaming:(UIView*)view;


/**
 表情雨
 @param view            添加到的View
 */
- (void)addEmittErexpressionFlaming:(UIView*)view image:(NSString*)image;

//表情雨销毁
-(void)holidayEmitteEndAnimations;

/** 结束飘落动画 */
-(void)driftEndAnimation;

/** 结束烟花动画(弃用) */
-(void)fireworksEndAnimation;
/** 结束烟花动画 */
-(void)fireworksEndAnimations;
/** 结束上浮动画 */
-(void)floatingEndAnimation;
/** 结束火焰动画 */
-(void)flamingEndAnimations;




@end
