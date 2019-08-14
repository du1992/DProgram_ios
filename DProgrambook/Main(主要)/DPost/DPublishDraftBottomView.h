//
//  DPublishDraftBottomView.h
//  Dprogramming
//
//  Created by DUCHENGWEN on 2017/12/17.
//  Copyright © 2017年 kevindcw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCustomTopImageButton : UIButton

@end








/**
 *  item类型
 */
typedef NS_ENUM(NSUInteger, DPublishDraftBottomViewItemType) {
    /** 图片*/
    DPublishDraftBottomViewItemTypePicture = 1,
    /** 视频*/
    DPublishDraftBottomViewItemTypeVideo,
    /** 匿名*/
    DPublishDraftBottomViewItemTypeAnonymous,
};

@class DPublishDraftBottomView;
@protocol DPublishDraftBottomViewDelegate <NSObject>
/** 点击回调*/
- (void)publishDraftBottomView:(DPublishDraftBottomView *)bottomView didClickItemWithType:(DPublishDraftBottomViewItemType)type;
@end

@interface DPublishDraftBottomView : UIView
@property (nonatomic, weak) id <DPublishDraftBottomViewDelegate> delegate;
/** 剩余可输入字数*/
@property (nonatomic, assign) NSInteger limitCount;

@end
