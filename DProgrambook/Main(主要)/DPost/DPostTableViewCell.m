//
//  DPostTableViewCell.m
//  Dprogramming
//
//  Created by DUCHENGWEN on 2017/12/16.
//  Copyright © 2017年 kevindcw. All rights reserved.
//

#import "DPostTableViewCell.h"


@implementation DHotRecommendView

- (void)setLayout{
    
    self.userInteractionEnabled = YES;
    self.layer.cornerRadius=5;
    
    UIImageView*imgView=[UIImageView new];
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.imgView=imgView;
    
    UIView*view=[UIView new];
    [self addSubview:view];
    view.backgroundColor=AppAlphaColor(0, 0, 0, 0.5);
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    UILabel*titleLabel=[UILabel new];
    titleLabel.textColor=[UIColor whiteColor];
    [self  addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.center.mas_equalTo(self);
    }];
    self.titleLabel=titleLabel;
}

@end






@implementation DHotRecommendCell

- (void)setLayout {
   
    
    CGFloat viewWidth= (SCREEN_WIDTH-60)/2;
    
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(25);
        make.size.mas_equalTo(CGSizeMake(viewWidth, viewWidth*0.58));
    }];
    self.videoView.imgView.image=[UIImage imageNamed:@"我的帖子"];
    self.videoView.titleLabel.text=@"我的帖子";
    
    
    [self.audioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.mas_top).offset(25);
        make.size.mas_equalTo(CGSizeMake(viewWidth, viewWidth*0.58));
    }];
    self.audioView.imgView.image=[UIImage imageNamed:@"我的消息"];
    self.audioView.titleLabel.text=@"我的消息";
    
}

-(UIView *)videoView{
    if (!_videoView) {
        _videoView = [[DHotRecommendView alloc]init];
        _videoView.layer.cornerRadius=3;
        _videoView.clipsToBounds = YES;
        [self addSubview:_videoView];
        UITapGestureRecognizer *logoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVideoViewClick)];
        [_videoView addGestureRecognizer:logoTaps];
        
    }
    return _videoView;
}
-(void)pushVideoViewClick{
    self.clickPushView(DPushViewTypeVideo);
}



-(UIView *)audioView{
    if (!_audioView) {
        _audioView = [[DHotRecommendView alloc]init];
        _audioView.layer.cornerRadius=3;
        _audioView.clipsToBounds = YES;
        [self addSubview:_audioView];
        UITapGestureRecognizer *logoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushAudioViewClick)];
        [_audioView addGestureRecognizer:logoTaps];
        
    }
    return _audioView;
}
-(void)pushAudioViewClick{
    self.clickPushView(DPushViewTypeAudio);
}

@end










@implementation DPostTableViewCell

-(void)setLayout{
    
    
   
    
    [self.userLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(15);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userLogoImageView.mas_top).offset(5);
        make.left.mas_equalTo(self.userLogoImageView.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-5);
    }];
    
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nickNameLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.userLogoImageView.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-5);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userLogoImageView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.right.mas_equalTo(self.mas_right).offset(-12);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(-0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
        make.height.equalTo(@1);
    }];

  
    
}







-(UILabel*)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel                 = [[UILabel alloc] init];
        _nickNameLabel.font            = AppFont(12);
        [self.contentView addSubview:_nickNameLabel];
    }
    
    return _nickNameLabel;
}

-(UILabel*)timeLabel{
    if (!_timeLabel) {
        _timeLabel                 = [[UILabel alloc] init];
         _timeLabel.font            = AppFont(12);
        _timeLabel.textColor       = AppColor(159, 159, 159);
        _timeLabel.textAlignment   = NSTextAlignmentLeft;
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

-(UILabel*)contentLabel{
    if (!_contentLabel) {
        _contentLabel                 = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font            = AppFont(14);
        _contentLabel.textColor       = [UIColor blackColor];
        _contentLabel.numberOfLines   = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

-(UIImageView*)userLogoImageView{
    if (!_userLogoImageView) {
        _userLogoImageView=[UIImageView new];
        _userLogoImageView.contentMode=UIViewContentModeScaleAspectFill;
        _userLogoImageView.clipsToBounds = YES;
        _userLogoImageView.layer.cornerRadius=20;
        [self addSubview:_userLogoImageView];
    }
    return _userLogoImageView;
}

-(UIView*)lineView{
    if (!_lineView) {
        _lineView=[UIView new];
        _lineView.backgroundColor=AppColor(234,232,234);
        [self addSubview:_lineView];
    }
    return _lineView;
}





-(void)setData:(DPostModel*)model{
    self.model=model;
     self.nickNameLabel.text   = @"昵称";
    if ([model.isAnonymous intValue]) {
       self.nickNameLabel.text   = @"匿名少侠";
       self.userLogoImageView.image=ImageNamed(@"匿名");
    }else{
       self.nickNameLabel.text   = model.nickName;
      [self.userLogoImageView sd_setImageWithURL:[NSURL URLWithString:model.userLogo] placeholderImage:ImageNamed(@"mohu")];
    }
   
  
    
    self.contentLabel.text = model.content;
    self.timeLabel.text    = model.dateTime;
    
    
   
    
}





@end












