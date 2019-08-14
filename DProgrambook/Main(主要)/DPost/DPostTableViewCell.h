//
//  DPostTableViewCell.h
//  Dprogramming
//
//  Created by DUCHENGWEN on 2017/12/16.
//  Copyright © 2017年 kevindcw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPostModel.h"


/**进入下一级页面： */
typedef NS_ENUM(NSInteger, DPushViewType){
    DPushViewTypeVideo = 1,
    DPushViewTypeAudio,
   
};


@interface DHotRecommendView : DView

/** 视图 */
@property (strong, nonatomic) UIImageView *imgView;
/** 标题*/
@property (strong, nonatomic) UILabel *titleLabel;


@end




@interface DHotRecommendCell : DTableViewCell
/** 视频视图 */
@property (strong, nonatomic) DHotRecommendView *videoView;
/** 音频视图 */
@property (strong, nonatomic) DHotRecommendView *audioView;
/** 推到下一个页面 */
@property (nonatomic, copy) void (^clickPushView) (DPushViewType type);

@end















@interface DPostTableViewCell : DTableViewCell

@property(nonatomic, strong) UIImageView *userLogoImageView;
@property(nonatomic,strong)UILabel  *nickNameLabel;
@property(nonatomic,strong)UILabel  *timeLabel;
@property(nonatomic,strong)UILabel  *contentLabel;







@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)DPostModel*model;
-(void)dataView:(DPostModel*)model;
@end
