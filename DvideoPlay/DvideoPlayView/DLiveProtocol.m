//
//  DLiveProtocol.m
//  DvideoPlay
//
//  Created by DUCHENGWEN on 2016/11/28.
//  Copyright © 2016年 DCW. All rights reserved.
//
//提醒视图

#import "DLiveProtocol.h"
#import "View+MASAdditions.h"
#import "Definition.h"

@interface DLiveProtocol ()



@property (nonatomic, strong) UIImageView *ForwardImage;
@property (nonatomic, strong) UILabel     *durationLabel;
@property (nonatomic, strong) UILabel     *currentPlaybackTimeLabel;

@end



@implementation DLiveProtocol

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5;
      
    }
    return self;
}

#pragma mark 快进提醒弹窗
-(void)addFITFastForwardView:(NSString*)ImgView durationString:(NSString*)durationString currentPlaybackTimeString:(NSString*)currentPlaybackTimeString{
    if (!_ForwardImage) {
        _ForwardImage=[[UIImageView alloc]init];
        [self addSubview:_ForwardImage];
        [_ForwardImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom).offset(-53);
            make.size.mas_equalTo(CGSizeMake(36, 20));
            make.centerX.equalTo(self);
        }];
        _durationLabel = [self lableWithFont:kFountSmall textColor:[UIColor whiteColor] superView:self];
        _currentPlaybackTimeLabel = [self lableWithFont:kFountSmall textColor:kYellowColor superView:self];
    }
    
    
    _ForwardImage.image=[UIImage imageNamed:ImgView];
    
    
    _durationLabel.frame=CGRectMake(8,45,62, 16);
    _durationLabel.text=durationString;
    _durationLabel.textAlignment=NSTextAlignmentRight;
    
    
    _currentPlaybackTimeLabel.frame=CGRectMake(70,45,80, 16);
    _currentPlaybackTimeLabel.text=currentPlaybackTimeString;
    _currentPlaybackTimeLabel.textAlignment=NSTextAlignmentLeft;
    
    
    
}



#pragma mark UI设置
-(UILabel *)lableWithFont:(UIFont *)font textColor:(UIColor *)textColor superView:(UIView *)superView{
    UILabel *lable = [[UILabel alloc] init];
    lable.font = font;
    lable.textColor = textColor;
    [superView addSubview:lable];
    return lable;
}


@end
