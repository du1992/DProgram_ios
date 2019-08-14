//
//  DButton.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/14.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^finishBlock)(void);
typedef void(^AnimationStartBlock)(void);

@interface DButton : DView

@property (nonatomic,copy)   finishBlock          translateBlock;
@property(nonatomic,strong)  AnimationStartBlock  animationStartBlock;
@property (nonatomic,strong) UIButton    *button;
@property (nonatomic,strong) UIColor     *dynamicColor;

- (void)setTitle:(NSString *)title font:(UIFont*)font titleColor:(UIColor*)titleColor;
- (void)setImage:(nullable UIImage *)image;


-(void)initializeButton;
//开始动画
-(void)startAllAnimation:(AnimationStartBlock _Nullable )animationStartBlock;
//删除动画
-(void)removeAllAnimation;
//暂停
- (void)pauseAnimation;
//恢复
- (void)resumeLayer;



@end

NS_ASSUME_NONNULL_END
