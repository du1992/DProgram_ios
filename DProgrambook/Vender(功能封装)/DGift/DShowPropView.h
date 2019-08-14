//  GetOn
//
//  Created by DUCHENGWEN on 2017/6/2.
//  Copyright © 2017年 Tonchema. All rights reserved.

//显示道具view

#import <UIKit/UIKit.h>
#import "DPropsMode.h"

@class DPlayDecorateView;


//汽车视图动画
@interface DCarAnimation : UIView


@property (nonatomic, strong) DPropsModel     *model;
@property (nonatomic, assign) BOOL            isNeedWait;
@property (nonatomic, copy) void(^animationDidFinished) ();

-(void)didReceiveProp:(DPropsModel  *)model;
//清空道具
-(void)clearProp;

@end


//飞机视图动画

@interface DUFOAnimation : UIView

@property (nonatomic, strong) DPropsModel   *model;
@property (nonatomic, assign) BOOL            isNeedWait;
@property (nonatomic, copy) void(^animationDidFinished) ();
-(void)didReceiveProp:(DPropsModel  *)model;

@end

//外星人
@interface DUFYXROAnimation : UIView

@property (nonatomic, strong) DPropsModel   *model;
@property (nonatomic, assign) BOOL            isNeedWait;
@property (nonatomic, copy) void(^animationDidFinished) ();
-(void)didReceiveProp:(DPropsModel  *)model;

@end



//带你飞视图动画
@interface DPeopleAnimation : UIView

@property (nonatomic, strong) DPropsModel   *model;
@property (nonatomic, assign) BOOL            isNeedWait;
@property (nonatomic, copy) void(^animationDidFinished) ();

-(void)didReceiveProp:(DPropsModel  *)model;

@end






@interface DShowPropView : UIView

-(instancetype)initWithFrame:(CGRect)frame bottomSpace:(CGFloat)bottomSpace;
@property(nonatomic, strong) UIView                *logicView;
@property(nonatomic, strong) UIImageView           *layerImg;
@property (nonatomic, copy) void (^didSelectedView) ();
@property (nonatomic, copy) void(^animationDidFinished) ();
-(void)didReceiveProp:(DPropsModel  *)model;

//清空道具
-(void)clearProp;

@end
