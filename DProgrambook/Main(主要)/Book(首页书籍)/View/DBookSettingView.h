//
//  DBookSettingView.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/3.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBookSettingTopView : DView

@property(nonatomic, strong) UIButton       *leftButton;
@property(nonatomic, strong) UIButton       *rightButton;
@property(nonatomic, strong) UILabel         *titleLabel;

@end


@interface DBookSettingBottomView : DView

@property(nonatomic, strong) UIButton       *colorButton;
@property(nonatomic, strong) UIButton       *settingButton;

@end



@interface DBookSettingManager : NSObject

-(void)initializeView:(UIView*)parentView;

@property(nonatomic, strong) DBookSettingTopView       *topView;
@property(nonatomic, strong) DBookSettingBottomView    *bottomView;

/*夜间白天*/
@property (nonatomic, copy)   void (^onSettingViewDidChangeColor) (void);
/*设置*/
@property (nonatomic, copy)   void (^onSettingViewDidChange) (void);
/*返回*/
@property (nonatomic, copy)   void (^onSettingViewDidChangeReturn) (void);
/*章节*/
@property (nonatomic, copy)   void (^onSettingViewDidChangeChapter) (void);
/**
 *  点击按钮弹出
 */
-(void)show;
/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss;

@end




NS_ASSUME_NONNULL_END
