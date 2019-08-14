//
//  DButton.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/14.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DButton.h"

#pragma mark -  用户反馈按钮
@interface DButton()

//渲染层
@property (nonatomic,strong) CAShapeLayer *maskLayer;

@property (nonatomic,strong) CAShapeLayer *shapeLayer;

@property (nonatomic,strong) CAShapeLayer *loadingLayer;

@property (nonatomic,strong) CAShapeLayer *clickCicrleLayer;

//@property (nonatomic,strong) CAShapeLayer *clickCicrleLayer;

@property (nonatomic,strong) UIColor*color;
@end


@implementation DButton

-(void)setLayout{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = self.bounds;
    [self addSubview:_button];
    [_button addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setImage:(nullable UIImage *)image{
    [_button setImage:image forState:0];
    
}
-(void)initializeButton{
    _shapeLayer = [self drawMask:self.frame.size.height/2];
    _shapeLayer.fillColor   = [UIColor clearColor].CGColor;
    _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    _shapeLayer.lineWidth = 2;
    [self.layer addSublayer:self.shapeLayer];
    [self.layer addSublayer:self.maskLayer];
    
}

-(CAShapeLayer *)maskLayer{
    if(!_maskLayer){
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.opacity = 0;
        _maskLayer.fillColor = [UIColor whiteColor].CGColor;
        _maskLayer.path = [self drawBezierPath:self.frame.size.width/2].CGPath;
    }
    return _maskLayer;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}



-(void)clickBtn{
    if (_button.selected) {
        return;
    }
    if(self.translateBlock){
        self.translateBlock();
    }
    
}
//开始动画
-(void)startAllAnimation:(AnimationStartBlock)animationStartBlock{
    self.animationStartBlock=animationStartBlock;
    self.button.selected=YES;
    [self initializeButton];
    [self clickAnimation];
    
}
-(void)clickAnimation{
    CAShapeLayer *clickCicrleLayer = [CAShapeLayer layer];
    clickCicrleLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    clickCicrleLayer.fillColor = [UIColor whiteColor].CGColor;
    clickCicrleLayer.path = [self drawclickCircleBezierPath:0].CGPath;
    [self.layer addSublayer:clickCicrleLayer];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.duration = 0.09;
    basicAnimation.toValue = (__bridge id _Nullable)([self drawclickCircleBezierPath:(self.bounds.size.height - 10*2)/2].CGPath);
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [clickCicrleLayer addAnimation:basicAnimation forKey:@"clickCicrleAnimation"];
    
    _clickCicrleLayer = clickCicrleLayer;
    
    [self performSelector:@selector(clickNextAnimation) withObject:self afterDelay:basicAnimation.duration];
}

-(void)clickNextAnimation{
    _clickCicrleLayer.fillColor = [UIColor clearColor].CGColor;
    _clickCicrleLayer.strokeColor =self.dynamicColor.CGColor;
    _clickCicrleLayer.lineWidth = 10;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.duration = 0.09;
    basicAnimation.toValue = (__bridge id _Nullable)([self drawclickCircleBezierPath:(self.bounds.size.height - 10*2)].CGPath);
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAnimation1.beginTime = 0.10;
    basicAnimation1.duration = 0.09;
    basicAnimation1.toValue = @0;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeForwards;
    
    animationGroup.duration = basicAnimation1.beginTime + basicAnimation1.duration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.animations = @[basicAnimation,basicAnimation1];
    
    [_clickCicrleLayer addAnimation:animationGroup forKey:@"clickCicrleAnimation1"];
    
    [self performSelector:@selector(startMaskAnimation) withObject:self afterDelay:animationGroup.duration];
    
}

-(void)startMaskAnimation{
    _maskLayer.opacity = 0.15;
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.duration = 0.25;
    basicAnimation.toValue = (__bridge id _Nullable)([self drawBezierPath:self.frame.size.height/2].CGPath);
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    [_maskLayer addAnimation:basicAnimation forKey:@"maskAnimation"];
    
    [self performSelector:@selector(dismissAnimation) withObject:self afterDelay:basicAnimation.duration+0.07];
}

-(void)dismissAnimation{
    //    [self removeLayer];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.duration = 0.09;
    basicAnimation.toValue = (__bridge id _Nullable)([self drawBezierPath:self.frame.size.width/2].CGPath);
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAnimation1.beginTime = 0.10;
    basicAnimation1.duration = 0.09;
    basicAnimation1.toValue = @0;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeForwards;
    
    animationGroup.animations = @[basicAnimation,basicAnimation1];
    animationGroup.duration = basicAnimation1.beginTime+basicAnimation1.duration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    [_shapeLayer addAnimation:animationGroup forKey:@"dismissAnimation"];
    
    [self performSelector:@selector(loadingAnimation) withObject:self afterDelay:animationGroup.duration];
}



-(void)loadingAnimation{
    self.color=self.backgroundColor;
    self.backgroundColor=[UIColor clearColor];
    self.alpha=0.3;
    _button.hidden=YES;
    [self startLoadingLayer];
    
    
    //  self.backgroundColor= RGBACOLOR(0,0, 0, 0);
    //    [self performSelector:@selector(removeAllAnimation) withObject:self afterDelay:1];
    
}

-(void)startLoadingLayer{
    _loadingLayer = [CAShapeLayer layer];
    _loadingLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    _loadingLayer.fillColor = [UIColor clearColor].CGColor;
    _loadingLayer.strokeColor = self.dynamicColor.CGColor;
    _loadingLayer.lineWidth = 2;
    _loadingLayer.path = [self drawLoadingBezierPath].CGPath;
    [self.layer addSublayer:_loadingLayer];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(M_PI*2);
    basicAnimation.duration = 0.5;
    basicAnimation.repeatCount = LONG_MAX;
    [_loadingLayer addAnimation:basicAnimation forKey:@"loadingAnimation"];
    
    if (self.animationStartBlock) {
        self.animationStartBlock();
    }
}

//删除动画
-(void)removeAllAnimation{
    self.alpha=1;
    _button.selected=NO;
    _button.hidden=NO;
    if (self.shapeLayer) {
        [self.shapeLayer removeFromSuperlayer];
    }
    if (self.maskLayer) {
        [self.maskLayer removeFromSuperlayer];
    }
    if (_clickCicrleLayer) {
        [_clickCicrleLayer removeFromSuperlayer];
    }
    if (_loadingLayer) {
        [_loadingLayer removeFromSuperlayer];
    }
    self.backgroundColor=self.color;
}
//-(void)removeSubViews{
//    [_button removeFromSuperview];
//    [_maskLayer removeFromSuperlayer];
//    [_loadingLayer removeFromSuperlayer];
//    [_clickCicrleLayer removeFromSuperlayer];
//}




-(CAShapeLayer *)drawMask:(CGFloat)x{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = [self drawBezierPath:x].CGPath;
    return shapeLayer;
}

-(UIBezierPath *)drawBezierPath:(CGFloat)x{
    CGFloat radius = self.bounds.size.height/2 - 3;
    CGFloat right = self.bounds.size.width-x;
    CGFloat left = x;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    bezierPath.lineCapStyle = kCGLineCapRound;
    
    [bezierPath addArcWithCenter:CGPointMake(right, self.bounds.size.height/2) radius:radius startAngle:-M_PI/2 endAngle:M_PI/2 clockwise:YES];
    [bezierPath addArcWithCenter:CGPointMake(left, self.bounds.size.height/2) radius:radius startAngle:M_PI/2 endAngle:-M_PI/2 clockwise:YES];
    [bezierPath closePath];
    
    return bezierPath;
}


-(UIBezierPath *)drawLoadingBezierPath{
    CGFloat radius = self.bounds.size.height/2 - 3;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(0,0) radius:radius startAngle:M_PI/2 endAngle:M_PI/2+M_PI/2 clockwise:YES];
    return bezierPath;
}

-(UIBezierPath *)drawclickCircleBezierPath:(CGFloat)radius{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(0,0) radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    return bezierPath;
}
//[UIFont systemFontOfSize:17.f]
- (void)setTitle:(NSString *)title font:(UIFont*)font titleColor:(UIColor*)titleColor{
    [self.button setTitle:title forState:UIControlStateNormal];
    self.button.titleLabel.font =font ;
    [self.button setTitleColor:titleColor forState:UIControlStateNormal];
    
}


//暂停：取出暂停时的时间点，保存在layer.timeOffSet中，然后设置layer.speed = 0.0。

- (void)pauseAnimation

{
    if (_loadingLayer==nil) {
        return;
    }
    
    
}

// 恢复：从layer.timeOffSet中取出暂停的时间点，设置layer.speed = 1.0，然后计算从暂停时间到现在经过的时间，并设置给layer.beginTime。

- (void)resumeLayer

{
    if (_loadingLayer==nil||_button.selected==NO) {
        return;
    }
    if (self.layer) {
        [self.layer removeAllAnimations];
    }
    [_loadingLayer removeFromSuperlayer];
    [self startLoadingLayer];
    
}


@end
