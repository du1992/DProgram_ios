//
//  DBookHeaderView.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/1.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"
#import "DWaveView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBookHeaderView : DView

/** 背景视图 */
@property(nonatomic,strong)UIImageView  *bgImageView;
/** 封面 */
@property(nonatomic,strong)UIImageView  *coverImageView;
/** 标题 */
@property(nonatomic,strong)UILabel     *titleLabel;
/** 介绍 */
@property(nonatomic,strong)UILabel     *introduceLabel;
/** 波浪 */
@property(nonatomic,strong)DWaveView   *waveView;

/** 数据*/
@property (nonatomic, strong) NSMutableArray      *listArray;

-(void)refreshUI;

@end

NS_ASSUME_NONNULL_END
