//
//  DProblemCell.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/10.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DProblemCell : DTableViewCell

/** 背景视图 */
@property(nonatomic,strong)UIView  *bgView;
/** 图标 */
@property(nonatomic,strong)UIImageView  *iconImageView;
/** 指示图片 */
@property(nonatomic,strong)UIImageView  *indicatorImageView;
/** 标题 */
@property(nonatomic,strong)UILabel     *titleLabel;
/** 介绍 */
@property(nonatomic,strong)UILabel     *introduceLabel;


@end

NS_ASSUME_NONNULL_END
