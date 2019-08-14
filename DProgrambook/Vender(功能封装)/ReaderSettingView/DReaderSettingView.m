//
//  DReaderSettingView.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/3.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DReaderSettingView.h"

@interface DReaderSettingCell (){
    
}

@property (strong, nonatomic) UIView        *bgView;

@property (strong, nonatomic) UIView        *colorView;



@property (nonatomic)BOOL   isAnimationHidden;

@end



@implementation DReaderSettingCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.colorView = [[UIView alloc] init];
        self.colorView.layer.cornerRadius=17.5;
        
        
        [self.contentView addSubview:self.colorView];
        [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.center.mas_equalTo(self);
           make.size.mas_equalTo(CGSizeMake(35, 35));
        }];
        
        self.bgView = [[UIView alloc] init];
        self.bgView.layer.cornerRadius=22.5;
        self.bgView.layer.borderWidth = 2.0;
        [self.contentView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        
    }
    return self;
}

-(void)setData:(NSString*)color Index:(NSInteger)index{
    
    UIColor*colors=UIColorHex(color);
    self.bgView.layer.borderColor = colors.CGColor;
    self.colorView.backgroundColor=UIColorHex(color);
    self.bgView.hidden=YES;
    if ([DBookManager defaultManager].bgColorSelected==index) {
        self.bgView.hidden=NO;
    }
    
    
    
}





@end








@interface DReaderSettingView ()
@property (weak, nonatomic) IBOutlet UISlider *brightSlider;
@property (weak, nonatomic) IBOutlet UIButton *fontMinButton;
@property (weak, nonatomic) IBOutlet UIButton *fontPlusButton;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeLabel;





@property (weak, nonatomic) IBOutlet UISwitch *lockSwitch;

@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, weak) UIButton *lastButton;

@end





@implementation DReaderSettingView

+ (instancetype)viewFromNib
{
    id obj = nil;
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DReaderSettingView" owner:self options:nil];
    if (nib.count) {
         obj = [nib objectAtIndex:0];
        
         return obj;
    }
 
    return obj;
    
}
- (void)awakeFromNib
{
    [super awakeFromNib];

    self.colorArray=[DBookManager defaultManager].colorArray;
    [self setFontSize:[DBookManager defaultManager].fontSizeSelected];
    
   
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing =0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.collectionView setCollectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor =[UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[DReaderSettingCell class] forCellWithReuseIdentifier:@"DReaderSettingCell"];
   
    
    
}
- (IBAction)toggleSlider:(UISlider *)sender {
    //亮度
}

- (void)setFontSize:(float)fontSize
{
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%.0f",fontSize];
}

- (float)currentFont
{
    return [self.fontSizeLabel.text floatValue];
}

- (void)cancelAllSelect
{
    self.lastButton.selected = NO;
}

- (IBAction)clickMinFontButton {
    NSInteger fontSize=  [self currentFont] - 1;
    if (fontSize<10) {
        return;
    }
    [self setFontSize:fontSize];
    if (self.onSettingViewDidChangeFontSize) {
        self.onSettingViewDidChangeFontSize();
    }
    [DBookManager defaultManager].fontSizeSelected=fontSize;
    
}

- (IBAction)clickPlusFontButton {
    NSInteger fontSize=  [self currentFont] + 1;
    if (fontSize>30) {
        return;
    }
    [self setFontSize:fontSize];
    [DBookManager defaultManager].fontSizeSelected=fontSize;
    if (self.onSettingViewDidChangeFontSize) {
        self.onSettingViewDidChangeFontSize();
    }
}

- (IBAction)clickSwitch:(UISwitch *)sender {
    //不息屏
    [[UIApplication sharedApplication] setIdleTimerDisabled:sender.on];
}

- (void)setBright:(float)bright
{
    [self.brightSlider setValue:bright animated:YES];
}

- (void)setNotLock:(BOOL)lock
{
    self.lockSwitch.on = lock;
}





-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50,50);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0, 0);//分别为上、左、下、右
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    DReaderSettingCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DReaderSettingCell" forIndexPath:indexPath];
    NSString* color=self.colorArray[indexPath.row];
    [cell setData:color Index:indexPath.row];
    return cell;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.colorArray.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([DBookManager defaultManager].bgColorSelected!=indexPath.row) {
       [DBookManager defaultManager].bgColorSelected=indexPath.row;
       [self.collectionView reloadData];
        if (self.onSettingViewDidChangeBgColor) {
            self.onSettingViewDidChangeBgColor();
        }
    }
   

    
}

/**
 *  点击按钮弹出
 */
-(void)show{
    if (self.hidden) {
        self.hidden=NO;
        [UIView animateWithDuration: 0.35 animations: ^{
            self.frame=CGRectMake(0, kScreenHeight-250, kScreenWidth,250);
        } completion:^(BOOL finished) {
        }];
    }
    
}
/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss{
    if (!self.hidden) {
        [UIView animateWithDuration: 0.35 animations: ^{
            self.frame=CGRectMake(0, kScreenHeight, kScreenWidth,250);
        } completion:^(BOOL finished) {
            self.hidden=YES;
        }];
    }
}

@end
