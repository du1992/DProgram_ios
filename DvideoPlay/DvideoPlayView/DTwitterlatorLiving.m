//
//  DTwitterlatorLiving.m
//  DvideoPlay
//
//  Created by DUCHENGWEN on 2016/11/28.
//  Copyright © 2016年 DCW. All rights reserved.
//
//播放视图

#import "DTwitterlatorLiving.h"
#import "View+MASAdditions.h"
#import "Definition.h"
#import "DLiveProtocol.h"

@interface DTwitterlatorLiving ()


@property (nonatomic, strong) UIView     *navigationView;

@property (nonatomic, assign) BOOL              isTimeOut;
@property (nonatomic, strong) UIControl         *bgControl;
@property (nonatomic, assign) BOOL              sliderValueIsChanging;
@property(nonatomic,strong)   DLiveProtocol     *LiveProtoco;//提醒弹框


@end



@implementation DTwitterlatorLiving

-(DTwitterlatorLiving *)initWith:(DScreenDirection)screenDirection playURL:(NSString*)playURL{
    self = [super init];
    if (self) {
        _screenDirection = screenDirection;
        self.isTimeOut = NO;
        
        self.playURL=playURL;
        KSYMoviePlayerController *palyer = [[KSYMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_playURL]];
    
        self.backgroundColor=[UIColor  yellowColor];
        
        [palyer setVolume:1.0 rigthVolume:1.0];
        self.palyer = palyer;
        palyer.shouldEnableVideoPostProcessing = YES;
        [palyer setTimeout:10 readTimeout:10];
        [self addSubview:palyer.view];
        [palyer.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        palyer.scalingMode = MPMovieScalingModeAspectFit;
        palyer.view.backgroundColor = [UIColor blackColor];
        [palyer prepareToPlay];
        [palyer play];
        palyer.shouldAutoplay = YES;
        
        UIControl *bgControl = [[UIControl alloc] init];
        self.bgControl = bgControl;
        [bgControl addTarget:self action:@selector(bgControlAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgControl];
        [bgControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        
        UIView *navigationView = [[UIView alloc] init];
        self.navigationView = navigationView;
        [self addSubview:navigationView];
        navigationView.backgroundColor = COLOR_RGBA(0, 0, 0, 0.3);
        [navigationView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(64);
        }];
        
        UIButton *backButton = [self buttonWithAction:@selector(backButtonAction:) imageName:@"关闭" superView:navigationView];
        [backButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(navigationView).insets(UIEdgeInsetsMake(10, 0, 0, 0));
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        
        UILabel *titlelabel = [[UILabel alloc] init];
        [navigationView addSubview:titlelabel];
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backButton.mas_right);
            make.centerY.equalTo(backButton);
            make.right.equalTo(navigationView).offset(-81);
        }];
        titlelabel.textColor = [UIColor whiteColor];
        titlelabel.font = [UIFont systemFontOfSize:16];
        titlelabel.shadowColor = COLOR_RGBA(0, 0, 0, 0.5);
        titlelabel.shadowOffset = CGSizeMake(1, 1);
        self.titlelabel = titlelabel;
        self.titlelabel.text=@"kevindcw";
        
        
        UIButton *changeDirectionButton = [self buttonWithAction:@selector(changeDirectionButtonAction:) imageName:@"全屏" superView:self];
        self.changeDirectionButton = changeDirectionButton;
        [changeDirectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 5, 10));
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
     
        [self performSelector:@selector(automaticHiddenStatusBar) withObject:nil afterDelay:3];
        
        [self addObser];
        [self  setIsPlayback:YES];
        
        
    }
    return self;
}

-(void)setIsPlayback:(BOOL)isPlayback{
    _isPlayback = isPlayback;
    if (isPlayback) {
        UIView *sliderSuperView = [[UIView alloc] init];
        self.sliderSuperView = sliderSuperView;
        [_bgControl addSubview:sliderSuperView];
        [sliderSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(_bgControl).insets(UIEdgeInsetsMake(0, 0, 10, 0));
            make.height.mas_equalTo(40);
        }];
        
        UIButton *playButton = [self buttonWithAction:@selector(playButtonAction:) imageName:@"暂停" superView:sliderSuperView];
        playButton.selected = YES;
        [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sliderSuperView);
            make.left.equalTo(sliderSuperView).offset(15);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        //进度条
        [self initSlider:sliderSuperView playButton:playButton];
        
        //手势
        UISwipeGestureRecognizer*left=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
        left.direction=UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:left];
        UISwipeGestureRecognizer*right=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
        right.direction=UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:right];
        
        
        _LiveProtoco = [[DLiveProtocol alloc] init];
        _LiveProtoco.backgroundColor = [UIColor blackColor];
        _LiveProtoco.alpha = 0.6;
        [self addSubview:_LiveProtoco];
        [_LiveProtoco mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(140, 70));
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        _LiveProtoco.hidden=YES;
        
      }
}

#pragma mark 播放进度条
-(void)initSlider:(UIView*)sliderSuperView playButton:(UIButton*)playButton{
    UISlider *slider = [[UISlider alloc] init];
    self.sliderView = slider;
    [slider setThumbImage:[UIImage imageNamed:@"播放点"] forState:UIControlStateNormal];
    [sliderSuperView addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(sliderSuperView).insets(UIEdgeInsetsMake(5, 0, 0, 60));
        make.left.equalTo(playButton.mas_right).offset(15);
        make.height.mas_equalTo(20);
    }];
    [slider addTarget:self action:@selector(sliderValueChangedAction:) forControlEvents:UIControlEventValueChanged];
    [slider addTarget:self action:@selector(sliderTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
    slider.minimumValue = 0;
    slider.minimumTrackTintColor = kYellowColor;
    slider.maximumTrackTintColor = COLOR_RGBA(255, 255, 255, 0.5);
    
    UILabel *timeLable = [[UILabel alloc] init];
    [sliderSuperView addSubview:timeLable];
    self.timeLable = timeLable;
    timeLable.textColor = [UIColor whiteColor];
    timeLable.shadowColor = COLOR_RGBA(0, 0, 0, 0.5);
    timeLable.font = [UIFont systemFontOfSize:10];
    timeLable.text = @"00:00:00/00:00:00";
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(slider);
        make.bottom.equalTo(sliderSuperView);
    }];
}

-(void)sliderValueChangedAction:(UISlider *)slider{
    [DTwitterlatorLiving cancelPreviousPerformRequestsWithTarget:self selector:@selector(automaticHiddenStatusBar) object:nil];
    self.sliderValueIsChanging = YES;
    NSString *durationString = [self timeStringWithTime:_palyer.duration];
    NSString *currentPlaybackTimeString = [self timeStringWithTime:slider.value];
    self.timeLable.text = [NSString stringWithFormat:@"%@/%@",durationString,currentPlaybackTimeString];
    if (self.sliveValueDidChange) {
        self.sliveValueDidChange(slider);
    }
}

-(void)sliderTouchUpInsideAction:(UISlider *)slider{
    [DTwitterlatorLiving cancelPreviousPerformRequestsWithTarget:self selector:@selector(automaticHiddenStatusBar) object:nil];
    [self performSelector:@selector(automaticHiddenStatusBar) withObject:nil afterDelay:3];
    _palyer.currentPlaybackTime = slider.value;
    [_palyer play];
    self.sliderValueIsChanging = NO;
    if (self.sliveValueDidEndChange) {
        self.sliveValueDidEndChange(slider);
    }
    
}

-(void)palyTimeDidChangeWithTime:(CGFloat )time{
    if (_sliderValueIsChanging) {
        return;
    }
    
    NSTimeInterval timeInterVal = _palyer.currentPlaybackTime;
    
    CGFloat duration = _palyer.duration;
    
    NSString *durationString = [self timeStringWithTime:duration];
    NSString *currentPlaybackTimeString = [self timeStringWithTime:timeInterVal];
    _sliderView.maximumValue = duration;
    _sliderView.minimumValue = 0;
    _sliderView.value = time;
    self.timeLable.text = [NSString stringWithFormat:@"%@/%@",durationString,currentPlaybackTimeString];
    
}

-(NSString *)timeStringWithTime:(NSInteger )time{
    NSInteger second = time % 60;
    NSInteger minute = time / 60;
    minute = minute % 60;
    NSInteger hour = time / 3600;
    NSString *secondString = [NSString stringWithFormat:@"%zd",second];
    if ([secondString length] < 2) {
        secondString = [NSString stringWithFormat:@"0%@",secondString];
    }
    
    NSString *minuteString = [NSString stringWithFormat:@"%zd",minute];
    if ([minuteString length] < 2) {
        minuteString = [NSString stringWithFormat:@"0%@",minuteString];
    }
    
    NSString *hourString = [NSString stringWithFormat:@"%zd",hour];
    if ([hourString length] < 2) {
        hourString = [NSString stringWithFormat:@"0%@",hourString];
    }
    
    NSString *timerString = [NSString stringWithFormat:@"%@:%@:%@",hourString,minuteString,secondString];
    
    return timerString;
}

-(void)backButtonAction:(UIButton *)button{
    if (_didSelectedBackButton) {
        _didSelectedBackButton(button);
    }
}

-(void)changeDirectionButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"恢复"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"全屏"] forState:UIControlStateNormal];
    }
    if (_didSelectedChangeDirectionButton) {
        _didSelectedChangeDirectionButton(button);
    }
}

-(void)bgControlAction{
    _navigationView.hidden = !_navigationView.hidden;
    _changeDirectionButton.hidden = _navigationView.hidden;
    _sliderSuperView.hidden = _navigationView.hidden;
    [[UIApplication sharedApplication] setStatusBarHidden:self.navigationView.hidden withAnimation:NO];
    if (!self.navigationView.hidden) {
        [DTwitterlatorLiving cancelPreviousPerformRequestsWithTarget:self selector:@selector(automaticHiddenStatusBar) object:nil];
        [self performSelector:@selector(automaticHiddenStatusBar) withObject:nil afterDelay:3];
    }
}

//播放或暂停
-(void)playButtonAction:(UIButton *)button{
    if (_didSelectedPlayButton) {
        _didSelectedBackButton(button);
    }
    button.selected = !button.selected;
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
        [_palyer play];
    }else{
        [button setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_palyer pause];
    }
}

-(void)automaticHiddenStatusBar{
    self.navigationView.hidden = YES;
    _changeDirectionButton.hidden = YES;
    _sliderSuperView.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
}

-(void)setScreenDirection:(DScreenDirection)screenDirection{
    _screenDirection = screenDirection;
    if (_isPlayback) {
        return;
    }
    
    if (screenDirection == DScreenDirectionHorizontal) { //横屏
       [_changeDirectionButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 70, 15));
        }];
        
    }else{ //竖屏
     
        [_changeDirectionButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 5, 10));
        }];
    }
}

-(void)liveDidStop{
    [DTwitterlatorLiving cancelPreviousPerformRequestsWithTarget:self];
    [_palyer stop];
    [_palyer.view removeFromSuperview];
    _palyer = nil;
}

#pragma mark 通知事件

//播放器准备播放状态发送改变
-(void)handlePlayerNotify1:(NSNotification *)notification{
    NSLog(@"+++++%@++",notification.userInfo.description);
    NSLog(@"+++++++++++++++1");
}


//播放器状态发送改变
-(void)handlePlayerNotify2:(NSNotification *)notification{
    switch ( _palyer.playbackState) {
        case MPMoviePlaybackStateStopped:
            //            [self showLoadingMeg:@"播放停止" time:kDefaultShowTime];
            break;
        case MPMoviePlaybackStatePlaying:
            //            [self showLoadingMeg:@"正在播放" time:kDefaultShowTime];
            break;
        case MPMoviePlaybackStatePaused:
            //            [self showLoadingMeg:@"播放暂停" time:kDefaultShowTime];
            break;
        case MPMoviePlaybackStateInterrupted:
            //            [self showLoadingMeg:@"播放被打断" time:kDefaultShowTime];
            break;
        case MPMoviePlaybackStateSeekingForward:
            //            [self showLoadingMeg:@"向前seeking中" time:kDefaultShowTime];
            break;
        case MPMoviePlaybackStateSeekingBackward:
            //            [self showLoadingMeg:@"向后seeking中" time:kDefaultShowTime];
            break;
            
            
        default:
            break;
    }
    //
}

//当播放完成时提供通知
-(void)handlePlayerNotify3:(NSNotification *)notification{
    NSLog(@"+++++%@++",notification.userInfo.description);
    
  
    int reason = [[[notification userInfo] valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    if (reason == MPMovieFinishReasonPlaybackEnded){
        NSLog(@"正在重连");
        }else if (reason == MPMovieFinishReasonUserExited){
        NSLog(@"播放完成");
        }
}


//播放加载状态发送改变
-(void)handlePlayerNotify4:(NSNotification *)notification{
    switch (_palyer.loadState) {
        case MPMovieLoadStateUnknown:
            //            [self showLoadingMeg:@"加载情况未知" time:kDefaultShowTime];
            break;
        case MPMovieLoadStatePlayable:
            //            [self showLoadingMeg:@"加载完成，可以播放" time:kDefaultShowTime];
            break;
        case MPMovieLoadStatePlaythroughOK:
            //            [self showLoadingMeg:@"加载完成，如果shouldAutoplay为YES，将自动开始播放" time:kDefaultShowTime];
            break;
        case MPMovieLoadStateStalled:
            //            [self showLoadingMeg:@"如果视频正在加载中" time:kDefaultShowTime];
            break;
            
        default:
            break;
    }
    NSLog(@"+++++%@++",notification.userInfo.description);
    NSLog(@"+++++%@++++++++++4",notification.userInfo.description);
}

//当前视频宽高发送改变
-(void)handlePlayerNotify5:(NSNotification *)notification{
    NSLog(@"+++++%@++",notification.userInfo.description);
    NSLog(@"+++++++++++++++5");
   
    _isTimeOut = NO;

}


//播放器第一帧开始渲染
-(void)handlePlayerNotify6:(NSNotification *)notification{
    NSLog(@"+++++%@++",notification.userInfo.description);
    NSLog(@"+++++++++++++++6");
}

//播放器第一帧开始声音开始
-(void)handlePlayerNotify7:(NSNotification *)notification{
    NSLog(@"+++++%@++",notification.userInfo.description);
}

//建议刷新播放器
-(void)handlePlayerNotify8:(NSNotification *)notification{
    NSLog(@"+++++%@++",notification.userInfo.description);
    if (_isPlayback) {
        [_palyer reload:[NSURL URLWithString:self.playURL] flush:NO];
        
    }else{
        [_palyer reload:[NSURL URLWithString:self.playURL] flush:NO];
    }
}

-(void)addObser{
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify1:)
                                                name:(MPMediaPlaybackIsPreparedToPlayDidChangeNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify2:)
                                                name:(MPMoviePlayerPlaybackStateDidChangeNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify3:)
                                                name:(MPMoviePlayerPlaybackDidFinishNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify4:)
                                                name:MPMoviePlayerLoadStateDidChangeNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify5:)
                                                name:(MPMovieNaturalSizeAvailableNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify6:)
                                                name:(MPMoviePlayerFirstVideoFrameRenderedNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify7:)
                                                name:(MPMoviePlayerFirstAudioFrameRenderedNotification)
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify8:)
                                                name:(MPMoviePlayerSuggestReloadNotification)
                                              object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)shouldMute:(BOOL)isshouldMute{
    
    
    _palyer.shouldMute=isshouldMute;
}




#pragma mark - 滑动快进后退
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender

{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if ( _palyer.currentPlaybackTime-self.VerticaTime  <0) {
            return;
        }
        _LiveProtoco.hidden=NO;
        _palyer.currentPlaybackTime=_palyer.currentPlaybackTime-self.VerticaTime;
        CGFloat duration = _palyer.duration;
        [self palyTimeDidChangeWithTime:_palyer.currentPlaybackTime];
        [self handleSwipEsevent:@"后退"];
        NSLog(@"后退");
       }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if ( _palyer.currentPlaybackTime+self.VerticaTime  >_palyer.duration) {
            return;
        }
        _LiveProtoco.hidden=NO;
        _palyer.currentPlaybackTime=_palyer.currentPlaybackTime+self.VerticaTime;
        [self palyTimeDidChangeWithTime:_palyer.currentPlaybackTime];
        [self handleSwipEsevent:@"快进"];
        NSLog(@"快进");
    }
}
-(void)handleSwipEsevent:(NSString*)ImgString{
    self.timeLable.text = [NSString stringWithFormat:@"%@/%@",[self timeStringWithTime:_palyer.duration],[self timeStringWithTime:_palyer.currentPlaybackTime]];
    [_LiveProtoco addFITFastForwardView:ImgString durationString:[NSString stringWithFormat:@"%@/",[self timeStringWithTime:_palyer.duration]] currentPlaybackTimeString:[self timeStringWithTime:_palyer.currentPlaybackTime]];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _LiveProtoco.hidden=YES;
    });
    
}

-(UIButton *)buttonWithAction:(SEL)action imageName:(NSString *)imageName superView:(UIView *)superView{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (superView) {
        [superView addSubview:button];
    }
    button.clipsToBounds = YES;
    return button;
}
@end
