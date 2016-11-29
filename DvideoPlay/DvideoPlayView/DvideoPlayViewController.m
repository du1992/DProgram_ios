//
//  DvideoPlayViewController.m
//  DvideoPlay
//
//  Created by DUCHENGWEN on 2016/11/28.
//  Copyright © 2016年 DCW. All rights reserved.
//

#import "DvideoPlayViewController.h"
#import "Definition.h"
#import "View+MASAdditions.h"
#import "DTwitterlatorLiving.h"


@interface DvideoPlayViewController ()

@property (nonatomic, strong) DTwitterlatorLiving           *liveView;
@property (nonatomic, assign) DScreenDirection              screenDirection;
@property (nonatomic, strong) NSTimer                       *timer;

@end

@implementation DvideoPlayViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_liveView.palyer stop];
    _liveView.palyer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self  initLiving];
    [self loadePlayback];
    
}
-(void)initLiving{
    __weak DvideoPlayViewController *wekSelf = self;
    DTwitterlatorLiving *liveView = [[DTwitterlatorLiving alloc] initWith:DScreenDirectionVertical playURL:URL_playURL];
    self.liveView = liveView;
    [self.view addSubview:liveView];
    [liveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_width).multipliedBy(9/16.0).priority(900);
        make.height.lessThanOrEqualTo(self.view).priority(UILayoutPriorityRequired);
    }];
    
    liveView.didSelectedChangeDirectionButton = ^(UIButton *button){
        [wekSelf changeDirectionButtonAction:button];//横竖屏切换
    };
    liveView.sliveValueDidEndChange = ^(UISlider *sliderView){
        [wekSelf loadePlayback];
    };
}
#pragma mark 播放时间显示

-(void)loadePlayback{
    [self.timer invalidate];
    self.timer = nil;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    self.timer = timer;
    
}
-(void)timerAction:(NSTimer *)timer{
    
    NSTimeInterval timeInterVal = _liveView.palyer.currentPlaybackTime;
    if(timeInterVal + 1 >= _liveView.palyer.duration){
        if (_liveView.palyer.duration != 0 ) {
            [timer invalidate];
            timer = nil;
            NSLog(@"---------播放结束----------");
        }
     }
       [_liveView palyTimeDidChangeWithTime:timeInterVal];
}




#pragma mark 屏幕旋转
-(void)screenDidRotationWithScreenDirection:(DScreenDirection )screenDirection{
    self.screenDirection = screenDirection;
    if (screenDirection == DScreenDirectionVertical) {//竖屏
       
    }else{//横屏
       
    }
    [self.view layoutIfNeeded];
    
};
-(void)changeDirectionButtonAction:(UIButton *)but{
   
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    
    if (_liveView.screenDirection == DScreenDirectionVertical) {
      
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
        [self setNeedsStatusBarAppearanceUpdate];
        [UIView animateWithDuration:duration animations:^{
            self.view.transform = CGAffineTransformMakeRotation(M_PI*0.5);
            self.view.bounds = CGRectMake(0, 0, screen_width, screen_height);
        } completion:^(BOOL finished) {
            _liveView.screenDirection = DScreenDirectionHorizontal;
        }];
        
    }else{
       
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
        [self setNeedsStatusBarAppearanceUpdate];
       [UIView animateWithDuration:duration animations:^{
            self.view.transform = CGAffineTransformIdentity;
            self.view.bounds = CGRectMake(0, 0, screen_width, screen_height);
        } completion:^(BOOL finished) {
            _liveView.screenDirection = DScreenDirectionVertical;
        }];
        [self.view layoutIfNeeded];
    }
    [self.view layoutIfNeeded];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  if (self.screenDirection == DScreenDirectionVertical) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    }else{
        
    }
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
}

- (BOOL)shouldAutorotate{
    return NO;
}


@end
