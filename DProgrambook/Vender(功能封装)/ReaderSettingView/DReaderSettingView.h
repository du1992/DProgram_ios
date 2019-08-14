//
//  DReaderSettingView.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/3.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN





@interface DReaderSettingCell : UICollectionViewCell

-(void)setData:(NSString*)color Index:(NSInteger)index;

@end




@interface DReaderSettingView : DView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

+ (instancetype)viewFromNib;




@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/*背景颜色列表*/
@property (nonatomic, strong) NSArray     *colorArray;

/*设置字号*/
@property (nonatomic, copy)   void (^onSettingViewDidChangeFontSize) (void);
/*设置背景颜色*/
@property (nonatomic, copy)   void (^onSettingViewDidChangeBgColor) (void);


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
