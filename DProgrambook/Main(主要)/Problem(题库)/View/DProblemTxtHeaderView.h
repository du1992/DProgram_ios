//
//  DProblemTxtHeaderView.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/10.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DProblemTxtHeaderView : DView

/** 背景视图 */
@property(nonatomic,strong)UIImageView  *bgImageView;
/** 分割线 */
@property(nonatomic,strong)UIImageView  *segmentationImageView;
/** 标题 */
@property(nonatomic,strong)UILabel     *titleLabel;
/** 介绍视图 */
@property(nonatomic,strong)UIView      *introduceView;
/** 介绍 */
@property(nonatomic,strong)UILabel     *introduceLabel;

@property (nonatomic, strong) UIButton    * backButton;

@end

NS_ASSUME_NONNULL_END
