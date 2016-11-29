//
//  DTwitterlatorLiving.h
//  DvideoPlay
//
//  Created by DUCHENGWEN on 2016/11/28.
//  Copyright © 2016年 DCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KSYMediaPlayer/KSYMediaPlayer.h>
#import "DLiveProtocol.h"

typedef NS_ENUM(NSInteger,DScreenDirection) {
    DScreenDirectionHorizontal,//横屏
    DScreenDirectionVertical,  //竖屏
};

@interface DTwitterlatorLiving : UIView

@property (nonatomic, strong)   KSYMoviePlayerController        *palyer;//播放器
@property (nonatomic, assign)   DScreenDirection       screenDirection;//横竖屏
@property (nonatomic, assign)   BOOL          isPlayback;//是否显示
@property (nonatomic, assign)   NSString      * playURL;//播放地址
@property (nonatomic, assign)  int   VerticaTime;//每次快进几秒


@property (nonatomic, copy)     void (^didSelectedBackButton)               (UIButton *);
@property (nonatomic, copy)     void (^didSelectedChangeDirectionButton)    (UIButton *);
@property (nonatomic, copy)     void (^sliveValueDidChange)                 (UISlider *);
@property (nonatomic, copy)     void (^sliveValueDidEndChange)              (UISlider *);
@property (nonatomic, copy)     void (^didSelectedPlayButton)               (UIButton *);

//初始化视图
-(DTwitterlatorLiving *)initWith:(DScreenDirection)screenDirection playURL:(NSString*)playURL;
//播放时间
-(void)palyTimeDidChangeWithTime:(CGFloat )playTime;

//UI元素
@property (nonatomic, strong) UILabel           *titlelabel;
@property (nonatomic, strong) UIButton   *changeDirectionButton;
@property (nonatomic, strong) UISlider      *sliderView;
@property (nonatomic, strong) UILabel       *timeLable;
@property (nonatomic, strong) UIView        *sliderSuperView;


@end
