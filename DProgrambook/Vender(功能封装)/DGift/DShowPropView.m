//  GetOn
//
//  Created by DUCHENGWEN on 2017/6/2.
//  Copyright © 2017年 Tonchema. All rights reserved.

//显示道具view

#import "DShowPropView.h"
#import "DPropsMode.h"
#import "DParticleEmitter.h"
#import "UIImage+GIF.h"


@interface DUFYXROAnimation ()<NSObject>

@property (nonatomic, strong) UIView          *bgView;
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UIImageView     *headerImage;

@property (nonatomic, strong) UIImageView     *UFOImage;
@property (nonatomic, strong) UIBezierPath    *path1;
@property (nonatomic, strong) UIBezierPath    *path2;


@end

@implementation DUFYXROAnimation

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isNeedWait = NO;
        self.userInteractionEnabled = NO;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, self.width, self.height)];
        self.bgView = bgView;
        [self addSubview:bgView];
        //        bgView.backgroundColor = [UIColor yellowColor];
        
        UILabel *lable = [[UILabel alloc] init];
        self.titleLabel = lable;
        lable.textColor = AppColor(255, 226, 2);
        lable.shadowColor = AppAlphaColor(0, 0, 0, 0.5);
        [bgView addSubview:lable];
        //        lable.text = @"jhsgdjsgdsdjshgajdhsa";
        lable.font = [UIFont systemFontOfSize:14];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.height/2.0 - 65 - 20);
            make.centerX.equalTo(self.bgView);
        }];
        
        UIImageView *headerImage = [[UIImageView alloc] init];
        headerImage.layer.cornerRadius = 10;
        headerImage.layer.borderWidth = 1;
        headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
        //        headerImage.backgroundColor = [UIColor redColor];
        [bgView addSubview:headerImage];
        self.headerImage = headerImage;
        headerImage.clipsToBounds = YES;
        [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lable);
            make.right.equalTo(lable.mas_left).offset(-5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        
        
        UIImageView *UFOImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 206, 190)];
        [bgView addSubview:UFOImage];
        UFOImage.center = bgView.center;
        self.UFOImage = UFOImage;
        UFOImage.image = [UIImage imageNamed:@"二踢脚"];
        _bgView.hidden = YES;
        
    }
    return self;
}

-(void)starAnimation{
    self.isNeedWait = YES;
    CAKeyframeAnimation * moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = _path1.CGPath;
    moveAnimation.duration = 3;
    moveAnimation.beginTime = 0;
    moveAnimation.cumulative = YES;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.timingFunctions = @[
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]
                                      ];
    moveAnimation.removedOnCompletion = NO;
    CABasicAnimation *ba = [CABasicAnimation animation];
    ba.beginTime = 3;
    ba.duration = 1;
    
    CAKeyframeAnimation * moveAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation2.path = _path2.CGPath;
    moveAnimation2.duration = 0.8;
    moveAnimation2.beginTime = 4;
    moveAnimation2.fillMode = kCAFillModeForwards;
    moveAnimation2.timingFunctions = @[
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                       ];
    moveAnimation2.removedOnCompletion = NO;
    
    
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 4.8;
    groupAnnimation.fillMode = kCAFillModeForwards;
    groupAnnimation.removedOnCompletion = NO;
    groupAnnimation.delegate = self;
    groupAnnimation.animations = @[moveAnimation,ba,moveAnimation2];
    groupAnnimation.repeatCount = 1;
    _bgView.hidden = NO;
    [self.bgView.layer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
}


- (void)drawRect:(CGRect)rect {
    
    CGFloat centX = self.frame.size.width/2.0;
    CGFloat centY = self.frame.size.height/2.0;
    CGFloat ovalH = 80;
    
    
    UIBezierPath *pathLine = [UIBezierPath bezierPath];
    [pathLine moveToPoint:CGPointMake(-self.width/2.0, centY)];
    [pathLine addQuadCurveToPoint:CGPointMake(centX, centY + ovalH/2.0) controlPoint:CGPointMake(centX /2.0 - 50, 200)];
    
    
    UIBezierPath *p = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centX, centY - ovalH/2.0 ) radius:ovalH startAngle: M_PI_2 + M_PI * 2  endAngle:M_PI_2  clockwise:NO];
    [pathLine appendPath:p];
    
    
    
    
    UIBezierPath *pathLine2 = [UIBezierPath bezierPath];
    pathLine2.lineCapStyle = kCGLineCapRound;
    [pathLine2 moveToPoint:CGPointMake(centX, centY + ovalH/2.0)];
    [pathLine2 addQuadCurveToPoint:CGPointMake(centX * 2 + self.width, centY + ovalH/2.0) controlPoint:CGPointMake(centX + self.width/2.0, 220)];
    self.path2 = pathLine2;
    //    [pathLine2 stroke];
    //
    //     [pathLine stroke];
    
    self.path1 = pathLine ;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat centX = self.frame.size.width/2.0;
    CGFloat centY = self.frame.size.height/2.0;
    CGFloat ovalH = 80;
    
    
    UIBezierPath *pathLine = [UIBezierPath bezierPath];
    [pathLine moveToPoint:CGPointMake(-self.width/2.0, centY)];
    [pathLine addQuadCurveToPoint:CGPointMake(centX, centY + ovalH/2.0) controlPoint:CGPointMake(centX /2.0 - 50, 200)];
    
    
    UIBezierPath *p = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centX, centY - ovalH/2.0 ) radius:ovalH startAngle: M_PI_2 + M_PI * 2  endAngle:M_PI_2  clockwise:NO];
    [pathLine appendPath:p];
    
    
    
    
    UIBezierPath *pathLine2 = [UIBezierPath bezierPath];
    pathLine2.lineCapStyle = kCGLineCapRound;
    [pathLine2 moveToPoint:CGPointMake(centX, centY + ovalH/2.0)];
    [pathLine2 addQuadCurveToPoint:CGPointMake(centX * 2 + self.width, centY + ovalH/2.0) controlPoint:CGPointMake(centX + self.width/2.0, 220)];
    self.path2 = pathLine2;
    [pathLine2 stroke];
    
    [pathLine stroke];
    
    self.path1 = pathLine ;
}



-(void)didReceiveProp:(DPropsModel  *)model{
    [self starAnimation];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.faceUrl] placeholderImage:[UIImage imageNamed:@"user_default_header"]];
    self.titleLabel.text = [model getMessageUserName];
 
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.isNeedWait = NO;
    if (self.animationDidFinished) {
        _animationDidFinished();
    }
}


@end










//汽车视图动画
@interface DCarAnimation ()<NSObject,CAAnimationDelegate>

@property (nonatomic, strong) UIView          *bgView;
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UIImageView     *headerImage;
@property(strong,nonatomic)   DParticleEmitter*emitter;
@property (nonatomic, strong) UIImageView     *carImage;
@property (nonatomic, assign) CGFloat         carWidth;
@property (nonatomic, assign) CGFloat         carHeight;

@end

@implementation DCarAnimation

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isNeedWait = NO;
        self.carWidth = 347;
        self.carHeight = 136;
        self.userInteractionEnabled = NO;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.width + self.width , -_carWidth, self.width, self.height)];
        self.bgView = bgView;
        [self addSubview:bgView];
        
        UILabel *lable = [[UILabel alloc] init];
        self.titleLabel = lable;
        [bgView addSubview:lable];
        lable.textColor = AppAlphaColor(247,196,105, 1);
        lable.shadowColor = AppAlphaColor(0, 0, 0, 0.5);
        lable.font = [UIFont systemFontOfSize:14];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.height/2.0 - 65 - 20);
            make.centerX.equalTo(self.bgView);
        }];
        
        UIImageView *headerImage = [[UIImageView alloc] init];
        headerImage.layer.cornerRadius = 10;
        headerImage.layer.borderWidth = 1;
        headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
        //        headerImage.backgroundColor = [UIColor redColor];
        [bgView addSubview:headerImage];
        self.headerImage = headerImage;
        headerImage.clipsToBounds = YES;
        [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lable);
            make.right.equalTo(lable.mas_left).offset(-5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        headerImage.hidden=YES;
        
        UIImageView *carImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2.0, -_carWidth, _carWidth, _carHeight)];
        carImage.center = CGPointMake(self.width/2.0, self.height/2.0);
        
        [bgView addSubview:carImage];
        
        self.carImage = carImage;
        carImage.image = [UIImage imageNamed:@"car_gift_big"];
        
        
    }
    return self;
}

-(void)starAnimation{
    self.isNeedWait = YES;
    
    
   CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.width + _carWidth, -_carWidth)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake((self.width )/2.0, (self.height )/2.0)];
    positionAnimation.duration = 2;
    positionAnimation.beginTime = 0;
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *stopAnimation = [CABasicAnimation animation];
    stopAnimation.fillMode = kCAFillModeForwards;
    stopAnimation.removedOnCompletion = NO;
    stopAnimation.beginTime = 1.5 ;
    stopAnimation.duration = 1.5;
    
    CABasicAnimation *positionAnimation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation1.fromValue = positionAnimation.toValue;
    positionAnimation1.toValue = [NSValue valueWithCGPoint:CGPointMake(- _carWidth, self.height + _carWidth)];
    positionAnimation1.fillMode = kCAFillModeForwards;
    positionAnimation1.removedOnCompletion = NO;
    positionAnimation1.beginTime = 3;
    positionAnimation1.duration = 1;
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.duration = 5;
    group.delegate = self;
    group.animations = @[positionAnimation,stopAnimation,positionAnimation1];
    [self.bgView.layer addAnimation:group forKey:@"groupAnnimation"];
    
    
    
    
    
    
    
}

-(void)didReceiveProp:(DPropsModel *)model{
    [self starAnimation];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.faceUrl] placeholderImage:[UIImage imageNamed:@"user_default_header"]];
     NSString *str = [NSString stringWithFormat:@"%@的汽车",model.nickname];
     self.titleLabel.text=str;
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
//        [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[str rangeOfString:@"送的"]];
//        self.titleLabel.attributedText = string;
 
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.isNeedWait = NO;
    if (self.animationDidFinished) {
        _animationDidFinished();
    }
}
@end



//飞机✈️视图
@interface DUFOAnimation ()<NSObject>

@property (nonatomic, strong) UIView          *bgView;
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UIImageView     *headerImage;

@property (nonatomic, strong) UIImageView     *UFOImage;
@property (nonatomic, strong) UIBezierPath    *path1;
@property (nonatomic, strong) UIBezierPath    *path2;

@property (nonatomic, strong) CALayer * animationLayer;

/** 云1*/
@property(nonatomic,weak)UIImageView *cloud1ImageV;
/** 云2*/
@property(nonatomic,weak)UIImageView *cloud2ImageV;
/** 云3*/
@property(nonatomic,weak)UIImageView *cloud3ImageV;
/** 云4*/
@property(nonatomic,weak)UIImageView *cloud4ImageV;

/**
 背景图片
 */
@property(nonatomic,weak)UIImageView *bgImageView;

@end

@implementation DUFOAnimation

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isNeedWait = NO;
        self.userInteractionEnabled = NO;
        
        UIImageView *cloud1ImageV      = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-sunny-cloud-1"]];
        cloud1ImageV.contentMode=UIViewContentModeScaleAspectFit;
        self.cloud1ImageV              = cloud1ImageV;
        [self addSubview:cloud1ImageV];
        
        UIImageView *cloud2ImageV      = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-sunny-cloud-2"]];
        cloud2ImageV.contentMode=UIViewContentModeScaleAspectFit;
        self.cloud2ImageV              = cloud2ImageV;
        [self addSubview:cloud2ImageV];
        
        UIImageView *cloud3ImageV      = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-sunny-cloud-3"]];
        cloud3ImageV.contentMode=UIViewContentModeScaleAspectFit;
        self.cloud3ImageV              = cloud3ImageV;
        
        [self addSubview:cloud3ImageV];
        
        UIImageView *cloud4ImageV      = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-sunny-cloud-4"]];
        cloud4ImageV.contentMode=UIViewContentModeScaleAspectFit;
        self.cloud4ImageV              = cloud4ImageV;
        
        [self addSubview:cloud4ImageV];
        
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, self.width, self.height)];
        self.bgView = bgView;
        [self addSubview:bgView];
        //        bgView.backgroundColor = [UIColor yellowColor];
        
        UILabel *lable = [[UILabel alloc] init];
        self.titleLabel = lable;
        lable.textColor = AppAlphaColor(247,196,105, 1);
        lable.shadowColor = AppAlphaColor(0, 0, 0, 0.5);
        [bgView addSubview:lable];
        //        lable.text = @"jhsgdjsgdsdjshgajdhsa";
        lable.font = [UIFont systemFontOfSize:14];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.height/2.0 - 65 - 20);
            make.centerX.equalTo(self.bgView);
        }];
        
        UIImageView *headerImage = [[UIImageView alloc] init];
        headerImage.layer.cornerRadius = 10;
        headerImage.layer.borderWidth = 1;
        headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
        //        headerImage.backgroundColor = [UIColor redColor];
        [bgView addSubview:headerImage];
        self.headerImage = headerImage;
        headerImage.clipsToBounds = YES;
        [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lable);
            make.right.equalTo(lable.mas_left).offset(-5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        headerImage.hidden=YES;
        
        
        UIImageView *UFOImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 241, 103)];
        [bgView addSubview:UFOImage];
        UFOImage.center = bgView.center;
        self.UFOImage = UFOImage;
        UFOImage.image = [UIImage imageNamed:@"礼物_39"];
        _bgView.hidden = YES;
        
        
//        UIImageView *bgImageView       = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-sunny"]];
//        self.bgImageView               = bgImageView;
//        self.bgImageView.frame         = self.bounds;
//        [self addSubview:bgImageView];
//        self.bgImageView.hidden=YES;
        
       
        
        self.cloud1ImageV.hidden=YES;
        self.cloud2ImageV.hidden=YES;
        self.cloud3ImageV.hidden=YES;
        self.cloud4ImageV.hidden=YES;
        
        
        
    }
    return self;
}

/**
 云动画
 */
- (void)animationCloud:(CALayer*)layer toValue:(int)toValue duration:(int)duration{
  
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:layer.frame.origin];
    moveAnimation.toValue = @(toValue);
    moveAnimation.duration = duration;
    moveAnimation.beginTime = 0;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *ba = [CABasicAnimation animation];
    ba.beginTime = duration;
    ba.duration = 1;
    
    CABasicAnimation *moveAnimation2 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    moveAnimation2.fromValue = moveAnimation.toValue;
    moveAnimation2.toValue = [NSValue valueWithCGPoint:layer.frame.origin];
    moveAnimation2.fillMode = kCAFillModeForwards;
    moveAnimation2.removedOnCompletion = NO;
    moveAnimation2.beginTime = duration+1;
    moveAnimation2.duration = 1;
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.duration = 5;
     group.animations = @[moveAnimation,ba,moveAnimation2];
    [layer addAnimation:group forKey:@"groupAnnimation"];
    
}



-(void)starAnimation{
    self.isNeedWait = YES;
    
    //云动画
    //    self.bgImageView.hidden=NO;
    self.cloud1ImageV.hidden=NO;
    self.cloud2ImageV.hidden=NO;
    self.cloud3ImageV.hidden=NO;
    self.cloud4ImageV.hidden=NO;
    
    self.cloud1ImageV.frame        = CGRectMake(-120, 10,100*1 , 100*1);
    self.cloud2ImageV.frame        = CGRectMake(-150, 80, 100*1.8, 100*1.8);
    self.cloud3ImageV.frame        = CGRectMake(self.width+150, 100, 100*1.5, 100*1.5);
    self.cloud4ImageV.frame        = CGRectMake(self.width+120, 200, 100*0.8, 100*0.8);
    
    
    
    [self animationCloud:_cloud1ImageV.layer toValue:kScreenWidth/2+50 duration:3.2];
    [self animationCloud:_cloud2ImageV.layer toValue:kScreenWidth/2-80 duration:3.5];
    [self animationCloud:_cloud3ImageV.layer toValue:kScreenWidth/2+130 duration:3.8];
    [self animationCloud:_cloud4ImageV.layer toValue:kScreenWidth/2+50 duration:3];
    
    
    CAKeyframeAnimation * moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = _path1.CGPath;
    moveAnimation.duration = 3;
    moveAnimation.beginTime = 0;
    moveAnimation.cumulative = YES;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.timingFunctions = @[
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]
                                      ];
    moveAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *ba = [CABasicAnimation animation];
    ba.beginTime = 3;
    ba.duration = 1;
    
    CAKeyframeAnimation * moveAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation2.path = _path2.CGPath;
    moveAnimation2.duration = 0.8;
    moveAnimation2.beginTime = 4;
    moveAnimation2.fillMode = kCAFillModeForwards;
    moveAnimation2.timingFunctions = @[
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                       ];
    moveAnimation2.removedOnCompletion = NO;
    
    
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 4.8;
    groupAnnimation.fillMode = kCAFillModeForwards;
    groupAnnimation.removedOnCompletion = NO;
    groupAnnimation.delegate = self;
    groupAnnimation.animations = @[moveAnimation,ba,moveAnimation2];
    groupAnnimation.repeatCount = 1;
    _bgView.hidden = NO;
    [self.bgView.layer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
    
    
    
    self.animationLayer = [CALayer layer];
    self.animationLayer.frame = self.frame;
    [self.bgView.layer addSublayer:self.animationLayer];
   
    
    
    CALayer *balloonLayer    = [[CALayer alloc]init];
    balloonLayer.contents    = (__bridge id _Nullable)([UIImage imageNamed:@"balloon"].CGImage);
    balloonLayer.frame       = CGRectMake(-50, 0, 50, 65);
    [self.layer insertSublayer:balloonLayer below:_cloud3ImageV.layer];
    CAKeyframeAnimation *flightAnimation   = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flightAnimation.duration               = 5.;
    flightAnimation.values                 = @[
                                               [NSValue valueWithCGPoint:CGPointMake(-50, 0.)],
                                               [NSValue valueWithCGPoint:CGPointMake(150 , 160)],
                                               [NSValue valueWithCGPoint:CGPointMake(-50, self.cloud3ImageV.center.y)]
                                               ] ;
    flightAnimation.keyTimes               = @[@0.0, @0.5, @1.0];
    [balloonLayer addAnimation:flightAnimation forKey:nil];
    balloonLayer.position    = CGPointMake(-50, self.cloud3ImageV.center.y);

    
  
}


- (void)drawRect:(CGRect)rect {
    
    CGFloat centX = self.frame.size.width/2.0-20;
    CGFloat centY = self.frame.size.height/2.0;
    CGFloat ovalH = 80;
    
    
    UIBezierPath *pathLine = [UIBezierPath bezierPath];
    [pathLine moveToPoint:CGPointMake(self.width+centX, centY)];
    [pathLine addQuadCurveToPoint:CGPointMake(centX, centY + ovalH/2.0) controlPoint:CGPointMake(centX /2.0 - 50, 200)];
    
    
    UIBezierPath *p = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centX, centY - ovalH/2.0 ) radius:ovalH startAngle: M_PI_2 + M_PI * 2  endAngle:M_PI_2  clockwise:NO];
    [pathLine appendPath:p];
    
    
    
    
    UIBezierPath *pathLine2 = [UIBezierPath bezierPath];
    pathLine2.lineCapStyle = kCGLineCapRound;
    [pathLine2 moveToPoint:CGPointMake(centX, centY + ovalH/2.0)];
    [pathLine2 addQuadCurveToPoint:CGPointMake(-centX , centY + ovalH/2.0) controlPoint:CGPointMake(-centX , 220)];
    self.path2 = pathLine2;
    //    [pathLine2 stroke];
    //
    //     [pathLine stroke];
    
    self.path1 = pathLine ;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat centX = self.frame.size.width/2.0;
    CGFloat centY = self.frame.size.height/2.0;
    CGFloat ovalH = 80;
    
    
    UIBezierPath *pathLine = [UIBezierPath bezierPath];
    [pathLine moveToPoint:CGPointMake(-self.width/2.0, centY)];
    [pathLine addQuadCurveToPoint:CGPointMake(centX, centY + ovalH/2.0) controlPoint:CGPointMake(centX /2.0 - 50, 200)];
    
    
    UIBezierPath *p = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centX, centY - ovalH/2.0 ) radius:ovalH startAngle: M_PI_2 + M_PI * 2  endAngle:M_PI_2  clockwise:NO];
    [pathLine appendPath:p];
    
    
    
    
    UIBezierPath *pathLine2 = [UIBezierPath bezierPath];
    pathLine2.lineCapStyle = kCGLineCapRound;
    [pathLine2 moveToPoint:CGPointMake(centX, centY + ovalH/2.0)];
    [pathLine2 addQuadCurveToPoint:CGPointMake(centX * 2 + self.width, centY + ovalH/2.0) controlPoint:CGPointMake(centX + self.width/2.0, 220)];
    self.path2 = pathLine2;
    [pathLine2 stroke];
    
    [pathLine stroke];
    
    self.path1 = pathLine ;
}



-(void)didReceiveProp:(DPropsModel  *)model{
    [self starAnimation];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.faceUrl] placeholderImage:[UIImage imageNamed:@"user_default_header"]];
    NSString *str = [NSString stringWithFormat:@"%@的飞机",model.nickname];
    self.titleLabel.text=str;
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[str rangeOfString:@"送的"]];
//    self.titleLabel.attributedText = string;
    
   
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.isNeedWait = NO;
    [self.animationLayer removeFromSuperlayer];
    
    if (self.animationDidFinished) {
        _animationDidFinished();
        self.cloud1ImageV.hidden=YES;
        self.cloud2ImageV.hidden=YES;
        self.cloud3ImageV.hidden=YES;
        self.cloud4ImageV.hidden=YES;
    }
}


@end

//带你飞视图动画
@interface DPeopleAnimation ()<NSObject>

@property (nonatomic, strong) UIView          *bgView;
@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UIImageView     *headerImage;

@property (nonatomic, strong) UIImageView       *peopleImage;
@property (nonatomic, strong) UIImageView       *starImage;

@property (nonatomic, strong) UIImageView       *exhaustImage;
@end

@implementation DPeopleAnimation

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isNeedWait = NO;
        self.userInteractionEnabled = NO;
        
        UIImageView *exhaustImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,30,self.width, self.height)];
        [self addSubview:exhaustImage];
        self.exhaustImage = exhaustImage;
        exhaustImage.image = [UIImage imageNamed:@"带你飞气"];
        exhaustImage.alpha = 0;
        
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.width/2-36 ,self.height+200, 72, 121)];
        self.bgView = bgView;
//        bgView.backgroundColor=[UIColor yellowColor];
        
//        bgView.alpha = 0;
        bgView.transform = CGAffineTransformMakeRotation(M_PI);
        
        [self addSubview:bgView];
        
        UILabel *lable = [[UILabel alloc] init];
        self.titleLabel = lable;
        [bgView addSubview:lable];
        lable.textColor = AppAlphaColor(247,196,105, 1);
        lable.shadowColor = AppAlphaColor(0, 0, 0, 0.5);
        
        lable.font = [UIFont systemFontOfSize:14];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.height/2.0 - 65 - 20);
            make.centerX.equalTo(self.bgView);
        }];
        
        UIImageView *headerImage = [[UIImageView alloc] init];
        headerImage.layer.cornerRadius = 10;
        headerImage.layer.borderWidth = 1;
        headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
        //        headerImage.backgroundColor = [UIColor redColor];
        [bgView addSubview:headerImage];
        self.headerImage = headerImage;
        headerImage.clipsToBounds = YES;
        [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lable);
            make.right.equalTo(lable.mas_left).offset(-5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        headerImage.hidden=YES;
        
        UIImageView *peopleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 92, 197)];
        [bgView addSubview:peopleImage];
        self.peopleImage = peopleImage;
        //        peopleImage.alpha = 0;
        //        peopleImage.transform = CGAffineTransformMakeRotation(M_PI);
        peopleImage.image = [UIImage imageNamed:@"UFO_gift_big"];
//        peopleImage.center = self.center;
        
        
        UIImageView *starImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,kScreenHeight-70,kScreenWidth, 128)];
        [self addSubview:starImage];
        self.starImage = starImage;
        starImage.image = [UIImage imageNamed:@"带你飞云"];
        starImage.contentMode=UIViewContentModeScaleToFill;
        starImage.alpha = 0;
       
    }
    return self;
}

-(void)layoutSubviews{
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.centerX.equalTo(self.bgView);
    }];
    [super layoutSubviews];
    self.bgView.frame =  CGRectMake(self.width/2-36 ,self.height+300, 72, 150);
     self.peopleImage.frame = CGRectMake(0 ,25, 72, 121);
}

-(void)starAnimation{
    self.isNeedWait = YES;
    [self starImageAnimation];
    
    self.starImage.alpha = 1;
    [UIView animateWithDuration:1 animations:^{
        self.starImage.frame=CGRectMake(0,kScreenHeight-250,kScreenWidth, 128);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:6 animations:^{
            self.starImage.alpha = 0;
             self.starImage.frame=CGRectMake(0,kScreenHeight,kScreenWidth, 128);
        } completion:^(BOOL finished) {
            
        }];
        
       
    }];
    
    CABasicAnimation *rotateAnimation3 = [CABasicAnimation animation];
    rotateAnimation3.duration = 0.5;
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //    rotateAnimation.fromValue = [NSValue ] self.imageView.layer.transform;
    rotateAnimation.toValue = [NSNumber numberWithFloat:0 ];
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.duration = 0.5;
    rotateAnimation.beginTime = rotateAnimation3.duration;
    
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0 ];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1];
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.duration = 0.25;
    opacityAnimation.beginTime = rotateAnimation3.duration;
    
    
    CABasicAnimation *positionAnimation3 = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation3.fromValue = [NSValue valueWithCGPoint:CGPointMake((self.width )/2.0,self.height+200)];
    positionAnimation3.toValue = [NSValue valueWithCGPoint:CGPointMake((self.width )/2.0, (self.height )/2.0-40)];
    positionAnimation3.duration = 1.5;
    positionAnimation3.beginTime = 0;
    positionAnimation3.fillMode = kCAFillModeForwards;
    positionAnimation3.removedOnCompletion = NO;
    
    CABasicAnimation *positionAnimation4 = [CABasicAnimation animation];
    positionAnimation4.fillMode = kCAFillModeForwards;
    positionAnimation4.removedOnCompletion = NO;
    positionAnimation4.beginTime = 1.5 ;
    positionAnimation4.duration = 1.5;
    
    CABasicAnimation *positionAnimation5 = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation5.fromValue =positionAnimation3.toValue;
    positionAnimation5.toValue = [NSValue valueWithCGPoint:CGPointMake((self.width )/2.0, -200)];
    positionAnimation5.fillMode = kCAFillModeForwards;
    positionAnimation5.removedOnCompletion = NO;
    positionAnimation5.beginTime = 3;
    positionAnimation5.duration = 1;
    
    CABasicAnimation *positionAnimation6 = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation6.fromValue =positionAnimation5.toValue;
    positionAnimation6.toValue = [NSValue valueWithCGPoint:CGPointMake((self.width )/2.0, (self.height )/2.0-40)];
    positionAnimation6.fillMode = kCAFillModeForwards;
    positionAnimation6.removedOnCompletion = NO;
    positionAnimation6.beginTime = 3;
    positionAnimation6.duration = 1;
    
    CABasicAnimation *positionAnimation7 = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation7.fromValue =positionAnimation6.toValue;
    positionAnimation7.toValue = positionAnimation5.toValue;
    positionAnimation7.fillMode = kCAFillModeForwards;
    positionAnimation7.removedOnCompletion = NO;
    positionAnimation7.beginTime = 3;
    positionAnimation7.duration = 1;
    
    
    
    
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 6;
    //    groupAnnimation.autoreverses = YES;
    groupAnnimation.fillMode = kCAFillModeForwards;
    groupAnnimation.removedOnCompletion = NO;
    groupAnnimation.animations = @[positionAnimation3,positionAnimation4,positionAnimation5,rotateAnimation3,rotateAnimation,opacityAnimation,positionAnimation6,positionAnimation7];
    groupAnnimation.repeatCount = 1;
    groupAnnimation.delegate = self;
    
    //开演
    [self.bgView.layer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
    
    [UIView animateWithDuration:4 animations:^{
        self.exhaustImage.alpha = 1;
    } completion:^(BOOL finished) {
        self.exhaustImage.alpha = 0;
    }];
    
    
    
    
}

-(void)starImageAnimation{
//    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    rotateAnimation.fromValue = [NSNumber numberWithFloat:M_PI_2 ];
//    rotateAnimation.toValue = [NSNumber numberWithFloat:-M_PI ];
//    rotateAnimation.removedOnCompletion = NO;
//    rotateAnimation.fillMode = kCAFillModeForwards;
//    rotateAnimation.duration = 1;
//    
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAnimation.fromValue = [NSNumber numberWithFloat:0 ];
//    scaleAnimation.toValue = [NSNumber numberWithFloat:1 ];
//    scaleAnimation.removedOnCompletion = NO;
//    scaleAnimation.fillMode = kCAFillModeForwards;
//    scaleAnimation.duration = 1;
//    
//    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
//    groupAnnimation.duration = 1;
//    groupAnnimation.animations = @[rotateAnimation,scaleAnimation];
//    groupAnnimation.repeatCount = 1;
//    //开演
//    [self.starImage.layer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
    
    
}

-(void)didReceiveProp:(DPropsModel  *)model{
    [self starAnimation];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.faceUrl] placeholderImage:[UIImage imageNamed:@"user_default_header"]];
    NSString *str = [NSString stringWithFormat:@"%@带你飞",model.nickname];
    self.titleLabel.text=str;
    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[str rangeOfString:@"带"]];
//    self.titleLabel.attributedText = string;
    
   
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.isNeedWait = NO;
    if (self.animationDidFinished) {
        _animationDidFinished();
    }
}

@end











@interface DShowPropView ()

@property (nonatomic, strong) NSMutableArray        *propkeyArray;
@property (nonatomic, strong) NSMutableDictionary   *propDic;


@property (nonatomic, strong) UIImageView                *flameView;


@property (nonatomic, strong) DCarAnimation         *carAnimationView;
@property (nonatomic, strong) DUFOAnimation         *UFOAnimationView;
@property (nonatomic, strong) DUFYXROAnimation      *WXUFOAnimationView;
@property (nonatomic, strong) DPeopleAnimation      *peopleAnimationView;
@property(strong,nonatomic)   DParticleEmitter      *emitter;

@property (nonatomic, strong) NSMutableArray        *bigAnimationDataArray;
@property(nonatomic,  strong) UIImageView           *gifPlayImgView;

@property(nonatomic) BOOL isGifPlay;
//@property(nonatomic) BOOL isFlowersFall;
//@property(nonatomic) BOOL isFireworks;
//@property(nonatomic) BOOL isFloating;


@end

@implementation DShowPropView

-(instancetype)initWithFrame:(CGRect)frame bottomSpace:(CGFloat)bottomSpace{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self clearProp];
        
        __weak DShowPropView *weakSelf = self;
        
        if (!self.emitter) {
            DParticleEmitter *emitter = [[DParticleEmitter alloc] init];
            self.emitter=emitter;
        }
        
        
      DCarAnimation *carAnimationView = [[DCarAnimation alloc] initWithFrame:self.bounds];
        [self addSubview:carAnimationView];
        self.carAnimationView = carAnimationView;
        carAnimationView.animationDidFinished = ^(){
            [weakSelf checkBigAnimation];
        };
        carAnimationView.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor clearColor];
        
        DUFOAnimation *UFOAnimationView = [[DUFOAnimation alloc] initWithFrame:self.bounds];
        [self addSubview:UFOAnimationView];
        self.UFOAnimationView = UFOAnimationView;
        UFOAnimationView.animationDidFinished = ^(){
            if (weakSelf.isGifPlay) {
                
                weakSelf.layerImg.hidden=YES;
                weakSelf.layerImg.alpha = 1;
                weakSelf.isGifPlay=NO;
                [weakSelf checkBigAnimation];
            }
          
            
        };
       UFOAnimationView.backgroundColor = [UIColor clearColor];
        
        
        DUFYXROAnimation *WXUFOAnimationView = [[DUFYXROAnimation alloc] initWithFrame:self.bounds];
        [self addSubview:WXUFOAnimationView];
        self.WXUFOAnimationView = WXUFOAnimationView;
        WXUFOAnimationView.animationDidFinished = ^(){
            if (weakSelf.isGifPlay) {
                
                weakSelf.layerImg.hidden=YES;
                weakSelf.layerImg.alpha = 1;
                weakSelf.isGifPlay=NO;
                [weakSelf checkBigAnimation];
            }
            
            
        };
        WXUFOAnimationView.backgroundColor = [UIColor clearColor];
        
        
        
        
        DPeopleAnimation *peopleAnimationView = [[DPeopleAnimation alloc] initWithFrame:self.bounds];
        [self addSubview:peopleAnimationView];
        self.peopleAnimationView = peopleAnimationView;
        peopleAnimationView.animationDidFinished = ^(){
            [weakSelf checkBigAnimation];
            
        };

        peopleAnimationView.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
//    [_propView1 mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.height - (68 + 3.5) * 2);
//    }];
//    _propView1.originalTop = self.height - (68 + 3.5) * 2;
//    
//    [_propView2 mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.height - (68 + 3.5) * 1);
//    }];
//    _propView2.originalTop = self.height - (68 + 3.5) * 1;
    
    
    
    self.carAnimationView.frame = self.bounds;
    self.UFOAnimationView.frame = self.bounds;
    self.peopleAnimationView.frame = self.bounds;
    self.WXUFOAnimationView.frame = self.bounds;
    
    

//    [self layoutIfNeeded];
}

-(void)didReceiveProp:(DPropsModel *)model{

    

            if (![model.dribble intValue]) {
                [_bigAnimationDataArray addObject:model];
                [self checkBigAnimation];
                return ;
            }
           if ([self.propkeyArray containsObject:[model propSoleMark]]) { //包含
                    [self.propDic setObject:model forKey:[model propSoleMark]];
                }else{ //没包含
                  
                    [self.propkeyArray addObject:[model propSoleMark]];
                    [self.propDic setObject:model forKey:[model propSoleMark]];
                }
                
          
    
    
//        }
        
//    }
}




-(void)checkBigAnimation{
    //大礼物效果
    if ([_bigAnimationDataArray count] > 0 && !_carAnimationView.isNeedWait && !_UFOAnimationView.isNeedWait&& !_WXUFOAnimationView.isNeedWait && !_peopleAnimationView.isNeedWait&&!_isGifPlay ) {
        
        DPropsModel *model= [_bigAnimationDataArray firstObject];
        switch ([model.idString integerValue]) {
                
            case 0://飘花
                [self  flowerAnimation];
            break;
            
            
            
            
            case 1://送福
       
            [self sZhuFU];
            break;
            
            case 2://送花
            [self sXianHua];
            break;
            
            case 3://送奖杯
            [self sJiangBei];
            
            break;
            case 4://送糖果
            [self sTangGuo];
            break;
            
            
        
        case 5://带你飞
              [_peopleAnimationView didReceiveProp:model];
            break;
                
            case 6://兰博基尼
//                 [self carAnimation];
                 [_carAnimationView didReceiveProp:model];
                break;
           
            case 7://皮皮虾
                [self gifPlayAnimation];
               
                break;
            case 8://放烟花
            self.isGifPlay=YES;
            self.layerImg.image=[UIImage imageNamed:@"bg-sunny"];
            self.layerImg.hidden=NO;
            [_WXUFOAnimationView didReceiveProp:model];
                break;
            case 9://浪漫满屋
                [self  floatingAnimation];
                break;
            case 10://飞机
            self.isGifPlay=YES;
            self.layerImg.image=[UIImage imageNamed:@"bg-sunny"];
            self.layerImg.hidden=NO;
            [_UFOAnimationView didReceiveProp:model];
            
                break;
                
            default:
                break;
        }
        [_bigAnimationDataArray removeObject:model];
        
    }
}
//汽车动画
-(void)carAnimation{
    
    if (!_flameView) {
        _flameView=[UIImageView new];
        [self.logicView addSubview:_flameView];
        [self.logicView sendSubviewToBack:_flameView];
    }
     _flameView.frame = CGRectMake(0,0,kScreenWidth,kScreenHeight);
    _flameView.image=[UIImage imageNamed:@"火焰背景"];
//     [_emitter flaming:self.flameView];
    _flameView.alpha = 0;
    [UIView animateWithDuration:3 animations:^{
        self->_flameView.alpha = 1;
//        _flameView.frame = CGRectMake(SCREEN_WIDTH/2-150,SCREEN_HEIGHT/2-150,300,300);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            self->_flameView.alpha = 0;
//            _flameView.frame = CGRectMake(SCREEN_WIDTH/2-150,SCREEN_HEIGHT/2-150,300,300);
        } completion:^(BOOL finished) {
//            [_emitter flamingEndAnimations];
        }];
        
       
       
    }];
   
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });});
    
   
    
}

//屁屁虾
-(void)gifPlayAnimation{
    
    if (!_isGifPlay) {
        self.isGifPlay=YES;
        
        if (!_gifPlayImgView) {
            _gifPlayImgView=[[UIImageView alloc]init];
            [self animationUI:_gifPlayImgView];
            [self  addSubview:_gifPlayImgView];
        }
       
//        self.logicView.layerImg.image=[UIImage imageNamed:@"皮皮虾背景"];
//        self.logicView.layerImg.hidden=NO;
//        self.logicView.layerImg.contentMode=UIViewContentModeScaleAspectFill;
//        self.logicView.layerImg.alpha = 1;
        _gifPlayImgView.frame=CGRectMake(kScreenWidth,kScreenHeight-600,290,231);
        [UIView animateWithDuration:6 animations:^{
             _gifPlayImgView.frame = CGRectMake(-300,kScreenHeight-600,290,231);
        } completion:^(BOOL finished) {
             _gifPlayImgView.frame =CGRectMake(kScreenWidth,kScreenHeight-600,290,231);
             self.isGifPlay=NO;
            [self checkBigAnimation];
            [self viewDisappear];
        }];
    }
}


//浪漫满屋
-(void)floatingAnimation{
    
    self.isGifPlay=YES;
    self.layerImg.image=[UIImage imageNamed:@"泡泡背景"];
    self.layerImg.alpha = 1;
    self.layerImg.hidden=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_emitter floatingEndAnimation];
                [self viewDisappear];
        });});
       [_emitter addEmitterLayerFloating:self.logicView];
}
//烟花
-(void)fireworksAnimation{
    self.isGifPlay=YES;
    self.layerImg.image=[UIImage imageNamed:@"烟花背景"];
    self.layerImg.alpha = 0;
    self.layerImg.hidden=NO;
    [UIView animateWithDuration:5 animations:^{
        self.layerImg.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [_emitter fireworksEndAnimation];
            [self viewDisappear];
        });
    });
    [_emitter makeFireworksDisplay:self.logicView];
}

//撒花
-(void)flowerAnimation{
    self.isGifPlay=YES;
    self.layerImg.image=[UIImage imageNamed:@"撒花蒙版"];
    self.layerImg.hidden=NO;
    self.layerImg.alpha = 0.8;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//           [_emitter driftEndAnimation];
//            [self viewDisappear];
//        });
//    });
    [_emitter addEmitterLayerPosition:CGPointMake(kScreenWidth/2, -22) emitterSize:CGSizeMake(kScreenWidth, 0.0) view:self.logicView];
    
    
}



//送福
-(void)sZhuFU{
    
    self.isGifPlay=YES;
    self.layerImg.image=[UIImage imageNamed:@""];
    self.layerImg.alpha = 1;
    self.layerImg.hidden=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [_emitter holidayEmitteEndAnimations];
            [self viewDisappear];
        });});
    
    [_emitter addEmittErexpressionFlaming:self.logicView image:@"福字"];
   
}
//送花
-(void)sXianHua{
    
    self.isGifPlay=YES;
    self.layerImg.image=[UIImage imageNamed:@""];
    self.layerImg.alpha = 1;
    self.layerImg.hidden=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
             [_emitter holidayEmitteEndAnimations];
            [self viewDisappear];
        });});
    [_emitter addEmittErexpressionFlaming:self.logicView image:@"情人鲜花"];
}
//送奖杯
-(void)sJiangBei{
    
    self.isGifPlay=YES;
    self.layerImg.image=[UIImage imageNamed:@""];
    self.layerImg.alpha = 1;
    self.layerImg.hidden=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
             [_emitter holidayEmitteEndAnimations];
            [self viewDisappear];
        });});
    [_emitter addEmittErexpressionFlaming:self.logicView image:@"奖杯"];
}

//送糖果
-(void)sTangGuo{
    
    self.isGifPlay=YES;
    self.layerImg.image=[UIImage imageNamed:@""];
    self.layerImg.alpha = 1;
    self.layerImg.hidden=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
             [_emitter holidayEmitteEndAnimations];
            [self viewDisappear];
        });});
      [_emitter addEmittErexpressionFlaming:self.logicView image:@"糖果"];
}








-(void)viewDisappear{
    
    [UIView animateWithDuration:1 animations:^{
        self.layerImg.alpha = 0;
    } completion:^(BOOL finished) {
        self.isGifPlay=NO;
        self.layerImg.hidden=YES;
        self.layerImg.alpha = 1;
        [self checkBigAnimation];
    }];
    
    
}

-(void)animationUI:(UIImageView*)animationImageView{
    NSArray *magesArray = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"皮皮虾1"],
                           [UIImage imageNamed:@"皮皮虾2"],
                           nil];
    
    
    animationImageView.animationImages = magesArray;//将序列帧数组赋给UIImageView的animationImages属性
    animationImageView.animationDuration = 0.5;//设置动画时间
    animationImageView.animationRepeatCount = 0;//设置动画次数 0 表示无限
    [animationImageView startAnimating];//开始播放动画
    

}



-(void)controlAction:(UIColor *)control{
    if (_didSelectedView) {
        _didSelectedView();
    }
}

//-(void)setModel:(HomePageModel *)model{
//    _model = model;
//    _propView1.homePageModel = model;
//    _propView2.homePageModel = model;
//    _carAnimationView.model = model;
//    _UFOAnimationView.model = model;
//    _peopleAnimationView.model = model;
//}

-(void)clearProp{
    self.propkeyArray = [NSMutableArray array];
    self.propDic = [NSMutableDictionary dictionary];
    self.bigAnimationDataArray = [NSMutableArray array];
   
}

@end
