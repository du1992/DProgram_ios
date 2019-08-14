
//  DGiftListView.h
//  GetOn
//
//  Created by DUCHENGWEN on 2017/6/2.
//  Copyright © 2017年 Tonchema. All rights reserved.

#import "DParticleEmitter.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>


@implementation DParticle

- (instancetype)init {
    self = [super init];
    if (self) {
        _delayTime = arc4random_uniform(3);
        _delayDuration = arc4random_uniform(6);
    }
    return self;
}

-(UIColor*)color {
    if (_customColor) {
        return _customColor;
    }
    return _color;
}

- (void)setRandomPointRange:(CGFloat)randomPointRange {
    _randomPointRange = randomPointRange;
    if (_randomPointRange != 0) {
        _point.x = _point.x - _randomPointRange + arc4random_uniform(_randomPointRange*2);
        _point.y = _point.y - _randomPointRange + arc4random_uniform(_randomPointRange*2);
    }
}
@end



@interface DEmitterLayer() {
    CGFloat _animTime;
    CGFloat _animDuration;
    CADisplayLink* _displayLink;
    int _count;
}
@property(nonatomic,strong)NSArray* particleArray;
@end
@implementation DEmitterLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.masksToBounds = NO;
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(emitterAnim:)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        _animTime = 0;
        _animDuration = 5;
        _count = 0;
        _ignoredWhite = NO;
        _ignoredBlack = NO;
        _beginPoint = CGPointMake(0, 0);
    }
    return self;
}

- (void)emitterAnim:(CADisplayLink*)displayLink {
    [self setNeedsDisplay];
    _animTime += 0.2;
}

-(void)drawInContext:(CGContextRef)ctx {
    int count = 0;
    for (DParticle *particle in _particleArray) {
        if (particle.delayTime > _animTime) {
            continue;
        }
        
        CGFloat curTime = _animTime - particle.delayTime;
        if (curTime >= _animDuration + particle.delayDuration) { //到达了目的地的粒子原地等待下没到达的粒子
            curTime =  _animDuration + particle.delayDuration;
            count ++;
        }
        
        CGFloat curX = [self easeInOutQuad:curTime begin:_beginPoint.x end:particle.point.x + self.bounds.size.width/2-CGImageGetWidth(_image.CGImage)/2 duration:_animDuration + particle.delayDuration];
        CGFloat curY = [self easeInOutQuad:curTime begin:_beginPoint.y end:particle.point.y + self.bounds.size.height/2 - CGImageGetHeight(_image.CGImage)/2-50 duration:_animDuration + particle.delayDuration];
        CGContextAddEllipseInRect(ctx, CGRectMake(curX , curY , 1, 1));
        const CGFloat* components = CGColorGetComponents(particle.color.CGColor);
        CGContextSetRGBFillColor(ctx, components[0], components[1], components[2], components[3]);
        CGContextFillPath(ctx);
    }
    if (count == _particleArray.count) {
        [self reset];
        if (_emitterDelegate && [_emitterDelegate respondsToSelector:@selector(onAnimEnd)]) {
            [_emitterDelegate onAnimEnd];
        }
    }
}
/*
 * 参数描述
 * time 动画执行到当前帧所进过的时间
 * beginPosition 起始的位置
 * endPosition 结束的位置
 * duration 持续时间
 */
- (CGFloat)easeInOutQuad:(CGFloat)time begin:(CGFloat)beginPosition end:(CGFloat)endPosition duration:(CGFloat)duration {
    CGFloat coverDistance = endPosition - beginPosition;
    time /= duration/2;
    if (time < 1) {
        return coverDistance/2 * pow(time, 2) + beginPosition;
    }
    time --;
    return -coverDistance/2 * (time*(time-2)-1) + beginPosition;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _particleArray = [self getRGBAsFromImage:image];
}

- (NSArray*)getRGBAsFromImage:(UIImage*)image {
    //1. get the image into your data buffer.
    CGImageRef imageRef = [image CGImage];
    NSUInteger imageW = CGImageGetWidth(imageRef);
    NSUInteger imageH = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4; //一个像素4字节
    NSUInteger bytesPerRow = bytesPerPixel * imageW;
    unsigned char *rawData = (unsigned char*)calloc(imageH*imageW*bytesPerPixel, sizeof(unsigned char)); //元数据
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, imageW, imageH, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, imageW, imageH), imageRef);
    CGContextRelease(context);
    
    //2. Now your rawData contains the image data in the RGBA8888 pixel format.
    CGFloat addY = (_maxParticleCount == 0) ? 1 : (imageH/_maxParticleCount);
    CGFloat addX = (_maxParticleCount == 0) ? 1 : (imageW/_maxParticleCount);
    NSMutableArray *result = [NSMutableArray new];
    for (int y = 0; y < imageH; y+=addY) {
        for (int x = 0; x < imageW; x+=addX) {
            NSUInteger byteIndex = bytesPerRow*y + bytesPerPixel*x;
            //rawData一维数组存储方式RGBA(第一个像素)RGBA(第二个像素)...
            CGFloat red   = ((CGFloat) rawData[byteIndex]     ) / 255.0f;
            CGFloat green = ((CGFloat) rawData[byteIndex + 1] ) / 255.0f;
            CGFloat blue  = ((CGFloat) rawData[byteIndex + 2] ) / 255.0f;
            CGFloat alpha = ((CGFloat) rawData[byteIndex + 3] ) / 255.0f;
            
            if (alpha == 0 ||
                (_ignoredWhite && (red+green+blue == 3)) ||
                (_ignoredBlack && (red+green+blue == 0))) {
                //要忽略的粒子
                continue;
            }
            
            DParticle *particle = [DParticle new];
            particle.color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
            particle.point = CGPointMake(x, y);
            if (_customColor) {
                particle.customColor = _customColor;
            }
            if (_randomPointRange > 0) {
                particle.randomPointRange = _randomPointRange;
            }
            
            [result addObject:particle];
        }
    }
    free(rawData);
    return result;
}

-(void)pause {
    _displayLink.paused = YES;
}
-(void)resume {
    _displayLink.paused = NO;
}
-(void)reset {
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
        _animTime = 0;
    }
}

-(void)restart {
    [self reset];
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(emitterAnim:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
@end





@interface DParticleEmitter (){
    CAEmitterLayer *driftEmitterLayer;     //飘落效果
    CAEmitterLayer *fireworksEmitterLayer; //烟花效果
    CAEmitterLayer *floatingEmitterLayer;  //上浮效果
    CAEmitterLayer *flamingEmitterLayer;   //火焰效果
    CAEmitterLayer *holidayEmitterLayer;   //节日祝福效果
    
}
@property(nonatomic,strong)DEmitterLayer  *emitterLayer;//烟花

@property(nonatomic,strong)UIImageView    *middleImg;

@end

@implementation DParticleEmitter

//飘落效果
- (instancetype)addEmitterLayerPosition:(CGPoint)emitterPosition emitterSize:(CGSize)emitterSize view:(UIView *)view {
    
    
    driftEmitterLayer = [CAEmitterLayer layer];
    //例子发射位置
    driftEmitterLayer.emitterPosition = CGPointMake(view.frame.size.width/2, -22) ;
    //发射源的尺寸大小
    driftEmitterLayer.emitterSize = CGSizeMake(view.frame.size.width, 0.0);
    
    //发射模式
    driftEmitterLayer.emitterMode = kCAEmitterLayerSurface;
    //发射源的形状
    driftEmitterLayer.emitterShape = kCAEmitterLayerLine;
    
    // 发射源初始化随机数产生的种子
    driftEmitterLayer.seed = (arc4random()%30)+1;
    
    [view.layer addSublayer:driftEmitterLayer];
    
    
    NSMutableArray<CAEmitterCell *> *stepEmitterCells = [NSMutableArray array];
    for (NSInteger i = 1; i < 20; i++) {
        
        
        //创建雪花类型的粒子
        CAEmitterCell *cell = [CAEmitterCell emitterCell];
        //粒子的名字
        cell.name = @"snow";
        //粒子参数的速度乘数因子
        cell.birthRate = 1.0;
        cell.lifetime = 30.0;
        //粒子速度
        cell.velocity =arc4random_uniform(100) + 100;
        //粒子的速度范围
        cell.velocityRange = 10;
        //粒子y方向的加速度分量
        cell.yAcceleration = 32;
        //周围发射角度
        cell.emissionRange = 0.5 * M_PI;
        //子旋转角度范围
        cell.spinRange = 0.25 * M_PI;
        cell.contents =(id)[[UIImage imageNamed:[NSString stringWithFormat:@"撒花%zd",i]] CGImage];
        //设置雪花形状的粒子的颜色
        //        cell.color = [[UIColor colorWithRed:0.200 green:0.258 blue:0.543 alpha:1.000] CGColor];
        //scale：缩放比例
        cell.scale=.5;
        
        
        
        [stepEmitterCells addObject:cell];
    }
    driftEmitterLayer.emitterCells = stepEmitterCells;
    
    return self;
}




//烟花
- (void)makeFireworksDisplay:(UIView*)view{
    // 粒子发射系统 的初始化
    fireworksEmitterLayer = [CAEmitterLayer layer];
    CGRect viewBounds = view.layer.bounds;
    // 发射源的位置
    fireworksEmitterLayer.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    // 发射源尺寸大小
    fireworksEmitterLayer.emitterSize = CGSizeMake(viewBounds.size.width/2.0, 0.0);
    // 发射模式
    fireworksEmitterLayer.emitterMode = kCAEmitterLayerOutline;
    // 发射源的形状
    fireworksEmitterLayer.emitterShape = kCAEmitterLayerLine;
    // 发射源的渲染模式
    fireworksEmitterLayer.renderMode = kCAEmitterLayerAdditive;
    // 发射源初始化随机数产生的种子
//    fireworksEmitterLayer.seed = (arc4random()%10)+1;
    
    /**
     *  添加发射点
     一个圆（发射点）从底下发射到上面的一个过程
     */
    CAEmitterCell* rocket  = [CAEmitterCell emitterCell];
    rocket.birthRate = 3.0; //是每秒某个点产生的effectCell数量
    rocket.emissionRange = 0.15 * M_PI; // 周围发射角度
    rocket.velocity = 400; // 速度
    rocket.velocityRange = 100; // 速度范围
    rocket.yAcceleration = 75; // 粒子y方向的加速度分量
    rocket.lifetime = 1.02; // effectCell的生命周期，既在屏幕上的显示时间要多长。
    
    // 下面是对 rocket 中的内容，颜色，大小的设置
    rocket.contents = (id) [[UIImage imageNamed:@"烟花03"] CGImage];
    rocket.scale = 0.2;
//    rocket.color = [[UIColor redColor] CGColor];
//    rocket.greenRange = 1.0;
//    rocket.redRange = 1.0;
//    rocket.blueRange = 1.0;
    rocket.spinRange = M_PI; // 子旋转角度范围
    
    /**
     * 添加爆炸的效果，突然之间变大一下的感觉
     */
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    burst.birthRate = 1.0;
    burst.velocity = 0;
    burst.scale = 5.5;
//    burst.redSpeed =-1.5;
//    burst.blueSpeed =+1.5;
//    burst.greenSpeed =+1.0;
    burst.lifetime = 0.35;
    
    /**
     *  添加星星扩散的粒子
     */
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    spark.scale=.5;
    spark.birthRate = 3;
    spark.velocity = 185;
    spark.emissionRange = 2* M_PI;
    spark.yAcceleration = 75; //粒子y方向的加速度分量
    spark.lifetime = 3;
    
    spark.contents = (id) [[UIImage imageNamed:@"烟花特效"] CGImage];
    spark.scaleSpeed =+0.5;
//    spark.greenSpeed =-0.1;
//    spark.redSpeed = 0.4;
//    spark.blueSpeed =-0.1;
    spark.alphaSpeed =-0.1; // 例子透明度的改变速度
//    spark.spin = 2* M_PI; // 子旋转角度
//    spark.spinRange = 2* M_PI;
    
    // 将 CAEmitterLayer 和 CAEmitterCell 结合起来
    fireworksEmitterLayer.emitterCells = [NSArray arrayWithObject:rocket];
    //在圈圈粒子的基础上添加爆炸粒子
    rocket.emitterCells = [NSArray arrayWithObject:burst];
    //在爆炸粒子的基础上添加星星粒子
    burst.emitterCells = [NSArray arrayWithObject:spark];
    // 添加到图层上
    [view.layer addSublayer:fireworksEmitterLayer];
    
}
//上浮
- (void)addEmitterLayerFloating:(UIView*)view{
 
    floatingEmitterLayer = [CAEmitterLayer layer];
    
    
    // 发射器的尺寸大小
    floatingEmitterLayer.emitterSize = CGSizeMake(kScreenWidth, 50);
    // 渲染模式
    floatingEmitterLayer.renderMode = kCAEmitterLayerUnordered;
    //
    floatingEmitterLayer.emitterShape = kCAEmitterLayerSphere;
    //
    floatingEmitterLayer.frame = view.bounds;
    
    NSMutableArray<CAEmitterCell *> *stepEmitterCells = [NSMutableArray array];
    for (NSInteger i = 1; i < 4; i++) {
        CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
        emitterCell.birthRate = 3;
        emitterCell.lifetime = arc4random_uniform(5) + 1;
        emitterCell.lifetimeRange = 1.5;
        // 粒子的图片内容
        UIImage *emitterCellImage = [UIImage imageNamed:[NSString stringWithFormat:@"泡泡_%zd",i]];
        emitterCell.contents = (__bridge id)emitterCellImage.CGImage;
        // 粒子飞行的速度
        emitterCell.velocity = arc4random_uniform(100) + 100;
        // 粒子飞行的速度
        emitterCell.velocityRange = 100;
        // 粒子飞行的方向（默认向屏幕的右边）
        emitterCell.emissionLongitude = - M_PI_2 ;
        // 粒子散射的范围
        emitterCell.emissionRange = M_PI_2 / 4;
        // 粒子缩放的倍数
        emitterCell.scale = 0.4;
        // 缩放比例范围
        emitterCell.scaleRange = 0.5;
        // 粒子透明度在生命周期内的改变速度
        emitterCell.alphaSpeed = 10;
        // 一个粒子的颜色alpha能改变的范围
        emitterCell.alphaRange = 2;
        
        [stepEmitterCells addObject:emitterCell];
    }
    floatingEmitterLayer.emitterPosition = CGPointMake((kScreenWidth - 50 ) / 2, kScreenHeight - 50);
    floatingEmitterLayer.emitterCells = stepEmitterCells;
    [view.layer addSublayer:floatingEmitterLayer];
    if (!_middleImg) {
      _middleImg=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 50, kScreenHeight/2 - 50, 100, 100)];
    }
//    _middleImg.alpha = 0;
//    _middleImg.image=[UIImage imageNamed:@"三生三世礼物"];
//    [view addSubview:_middleImg];
//    [UIView animateWithDuration:5 animations:^{
//        _middleImg.frame=CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2 - 100, 200, 200);
//        _middleImg.alpha = 1;
//    } completion:^(BOOL finished) {
//         _middleImg.alpha = 0;
//        _middleImg.frame=CGRectMake(SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT/2 - 50, 100, 100);
//    }];
    
    
    
    
    
    
}
//（弃用）

- (void)makeFireworksDisplays:(UIView*)view{
    UIImage* image = [UIImage imageNamed:@"烟花特效"];
    _emitterLayer = [DEmitterLayer new];
    _emitterLayer.bounds = view.bounds;
    _emitterLayer.position = view.center;
    _emitterLayer.beginPoint = CGPointMake(view.center.x,view.bounds.size.height);
    _emitterLayer.ignoredWhite = YES;
    _emitterLayer.image = image;
    [view.layer addSublayer:_emitterLayer];
}

//火焰
- (void)flaming:(UIView*)view{
    
    flamingEmitterLayer = [CAEmitterLayer layer];
    flamingEmitterLayer.frame = view.bounds;
    [view.layer addSublayer:flamingEmitterLayer];
    flamingEmitterLayer.renderMode = kCAEmitterLayerAdditive;//这会让重叠的地方变得更亮一些。
    flamingEmitterLayer.emitterPosition = CGPointMake(view.frame.size.width / 2.0, view.frame.size.height / 2.0);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"奖杯"].CGImage;
    cell.birthRate = 130;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    cell.scale=0.3;
    flamingEmitterLayer.emitterCells = @[cell];
}




-(void)driftEndAnimation{
   
    if (driftEmitterLayer) {
        [driftEmitterLayer removeFromSuperlayer];
    }
    
}
-(void)fireworksEndAnimation{
    
    if (fireworksEmitterLayer) {
        [fireworksEmitterLayer removeFromSuperlayer];
    }
    
}

-(void)floatingEndAnimation{
    
    if (floatingEmitterLayer) {
        [floatingEmitterLayer removeFromSuperlayer];
    }
    
}

-(void)fireworksEndAnimations{
    
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
    }
    
}

-(void)flamingEndAnimations{
    
    if (flamingEmitterLayer) {
        [flamingEmitterLayer removeFromSuperlayer];
    }
    
}


-(void)holidayEmitteEndAnimations{
    
    if (holidayEmitterLayer) {
        [holidayEmitterLayer removeFromSuperlayer];
    }
    
}


//表情雨
- (void)addEmittErexpressionFlaming:(UIView*)view image:(NSString*)image{
    //创建一个CAEmitterLayer
    holidayEmitterLayer = [CAEmitterLayer layer];
    
    //指定发射源的位置
    holidayEmitterLayer.emitterPosition = CGPointMake(view.bounds.size.width / 2.0, -10);
    //指定发射源的大小
    holidayEmitterLayer.emitterSize  = CGSizeMake(view.bounds.size.width, 0.0);
    //指定发射源的形状 和 模式
    holidayEmitterLayer.emitterShape = kCAEmitterLayerLine;
    holidayEmitterLayer.emitterMode  = kCAEmitterLayerOutline;
    //创建CAEmitterCell
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    //每秒多少个
    snowflake.birthRate = 3.0;
    //存活时间
    snowflake.lifetime = 5;
    //初速度
    snowflake.velocity = 30;//因为动画属于落体效果，所以我们只需要设置它在 y 方向上的加速度就行了。
    //初速度范围
    snowflake.velocityRange = 5;
    //y方向的加速度
    snowflake.yAcceleration = 60;
    //
    snowflake.emissionRange = 0;
    
    snowflake.contents  = (id) [[UIImage imageNamed:image] CGImage];
    //缩小
    snowflake.scale = 1;
    
    holidayEmitterLayer.emitterCells = [NSArray arrayWithObject:snowflake];
    
    [view.layer addSublayer:holidayEmitterLayer];
}


@end
