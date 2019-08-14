//
//  DBookHeaderView.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/1.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBookHeaderView.h"
#import "DBookModel.h"

#import "UIImageView+YYWebImage.h"
#import "UIImage+YYAdd.h"

@implementation DBookHeaderView

-(void)setLayout{
   
    self.bgImageView.frame=CGRectMake(0,0,kScreenWidth,240);
    self.coverImageView.frame=CGRectMake(20, 100,85, 115);
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverImageView.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.coverImageView.mas_top).offset(10);
        make.height.mas_equalTo(20);
    }];
   
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverImageView.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.coverImageView.mas_bottom).offset(0);
    }];
}

-(UIImageView*)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
        _bgImageView.image=ImageNamed(@"mohu");
        [self addSubview:_bgImageView];
    }
    return _bgImageView;
}
-(UIImageView*)coverImageView{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.clipsToBounds = YES;
        [self addSubview:_coverImageView];
    }
    return _coverImageView;
}

-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = AppFont(18);
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.text  =@"";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.shadowColor = [UIColor blackColor];
        _titleLabel.shadowOffset = CGSizeMake(0.5, 0.5);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
-(UILabel*)introduceLabel{
    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc]init];
        _introduceLabel.font = AppFont(15);
        _introduceLabel.textColor=[UIColor whiteColor];
        _introduceLabel.shadowColor = [UIColor blackColor];
        _introduceLabel.shadowOffset = CGSizeMake(0.5, 0.5);
        _introduceLabel.textAlignment = NSTextAlignmentCenter;
        _introduceLabel.numberOfLines   = 0;
        [self addSubview:_introduceLabel];
    }
    return _introduceLabel;
}

- (DWaveView *)waveView{
    if (!_waveView) {
        _waveView = [[DWaveView alloc] init];
        _waveView.frame=CGRectMake(0, 240,kScreenWidth, 10);

        _waveView.realWaveColor = [UIColor whiteColor];
         [self addSubview:_waveView];
        [_waveView startWaveAnimation];
       
    }
    return _waveView;
}

-(void)refreshUI{
    DBookManager *model=[DBookManager defaultManager];
    WEAKSELF
    [self.bgImageView setImageWithURL:[NSURL URLWithString:model.imageName] placeholder:ImageNamed(@"mohu") options:(YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation) completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        UIImage *blurImage = [image imageByBlurRadius:25 tintColor:nil tintMode:0 saturation:1.0 maskImage:nil];
        weakSelf.bgImageView.image = blurImage;
    }];
    
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:ImageNamed(@"mohu")];
    self.titleLabel.text=model.titleString;
    self.introduceLabel.text=model.introduction;
    
}
-(void)setData:(DBookModel *)model{
    

    
 
  
    
}

@end
