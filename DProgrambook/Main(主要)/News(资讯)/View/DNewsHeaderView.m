//
//  DNewsHeaderView.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/9.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DNewsHeaderView.h"
#import "DNewsModel.h"

#define BannerOffsetWidth (_cellMidSize.width+_line) //每次移动偏移量
#define BannerOffsetleft  (_line+_showLine)   //左侧偏移的差值

@interface DNewsHeaderView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
   
}

@property (strong, nonatomic) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger selectedIndex;//当前index
@property (nonatomic, assign) BOOL isOne;//是否是单张图片

@property (nonatomic,weak) NSTimer *timer;
@property (nonatomic, copy) NSArray *dataImgs;
@property (nonatomic, assign) CGFloat line;//间隙,默认为0
@property (nonatomic, assign) CGFloat showLine;//小cell露出间隙,默认为0
@property (nonatomic, assign) CGFloat zoom;//小cell露出间隙,默认为0
@property (nonatomic, assign) CGSize cellMidSize;
@property (nonatomic, assign) CGSize collectionSize;
@end





@implementation DNewsHeaderView

#pragma mark 控件初始化
- (instancetype)initWithFrame:(CGRect)frame line:(CGFloat)line showLine:(CGFloat)showLine cellMidSize:(CGSize)cellMidSize zoom:(CGFloat)zoom
{//带间隙banner
    if (self = [super initWithFrame:frame]) {
        self.hidesForSinglePage = YES;
        self.autoScroll = YES;
        self.scrollEnabledForSinglePage = YES;
        self.isOne = NO;
        self.zoom = zoom;
        self.autoScrollTimeInterval = 2.0f;
        self.line = line;
        self.showLine = showLine;
        self.cellMidSize = cellMidSize;
        self.collectionSize = frame.size;
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame cellMidSize:(CGSize)cellMidSize
{//普通banner
    return [self initWithFrame:frame line:0.0 showLine:0.0 cellMidSize:cellMidSize zoom:1];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _selectedIndex = 0;
        BannerLayout *layout = [[BannerLayout alloc] initLine:_line itemSize:_cellMidSize zoom:self.zoom];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, _collectionSize.width, _collectionSize.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[BannerCollectionViewCell class] forCellWithReuseIdentifier:@"BannerCollectionViewCell"];
    }
    return _collectionView;
}
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[BannerPageControl alloc] initWithFrame:CGRectMake(0, _collectionSize.height, _collectionSize.width, 15)];
        _pageControl.currentPageIndicatorTintColor = UIColorFromRGBValue(0x333333);
        _pageControl.pageIndicatorTintColor = UIColorFromRGBValue(0x999999);
    }
    return _pageControl;
}

#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataImgs.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BannerCollectionViewCell" forIndexPath:indexPath];
    if (_cellCornerRadius > 0) {
        cell.layer.cornerRadius = _cellCornerRadius;
        cell.layer.masksToBounds = YES;
    }
    if (_urlImgs.count > 0) {
        DNewsModel *model =_dataImgs[indexPath.row];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.captions] placeholderImage:_placeHolderImage];
        cell.titleLabel.text=model.title;
    } else if (_localImgs.count > 0) {
        if ([_dataImgs[indexPath.row] isKindOfClass:[NSString class]]) {
            cell.imageView.image = [UIImage imageNamed:_dataImgs[indexPath.row]];
        } else if ([_dataImgs[indexPath.row] isKindOfClass:[UIImage class]]) {
            cell.imageView.image = _dataImgs[indexPath.row];
        }
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataImgs.count > 0) {
        if (_clickBlock) {
            _clickBlock(indexPath.row-2);
        }
    }
}
#pragma mark 数据赋值
- (void)setUrlImgs:(NSArray *)urlImgs
{
    if (urlImgs.count > 0) {
        NSMutableArray *arr = [urlImgs mutableCopy];
        if (urlImgs.count == 1) {
            self.isOne = YES;
            [arr addObject:urlImgs[0]];
            [arr addObject:urlImgs[0]];
            [arr insertObject:urlImgs[urlImgs.count-1] atIndex:0];
            [arr insertObject:urlImgs[urlImgs.count-1] atIndex:0];
        } else {
            self.isOne = NO;
            [arr addObject:urlImgs[0]];
            [arr addObject:urlImgs[1]];
            [arr insertObject:urlImgs[urlImgs.count-1] atIndex:0];
            [arr insertObject:urlImgs[urlImgs.count-2] atIndex:0];
        }
        _urlImgs = [arr copy];
        _dataImgs = [arr copy];
        [_collectionView reloadData];
        _collectionView.contentOffset = CGPointMake(BannerOffsetWidth*2-BannerOffsetleft, 0);
        _selectedIndex = 0;
        _pageControl.numberOfPages = urlImgs.count;
        _pageControl.currentPage = _selectedIndex;
        if (urlImgs.count == 1) {//单张默认隐藏pageControl
            if (_hidesForSinglePage) {
                _pageControl.hidden = YES;
            }
            if (_scrollEnabledForSinglePage && _line == 0) {//单张默认无缝轮播图不滚动
                _collectionView.scrollEnabled = NO;
            }
        }
    }
}
- (void)setLocalImgs:(NSArray *)localImgs
{
    if (localImgs.count > 0) {
        NSMutableArray *arr = [localImgs mutableCopy];
        if (localImgs.count == 1) {
            self.isOne = YES;
            [arr addObject:localImgs[0]];
            [arr addObject:localImgs[0]];
            [arr insertObject:localImgs[localImgs.count-1] atIndex:0];
            [arr insertObject:localImgs[localImgs.count-1] atIndex:0];
        } else {
            self.isOne = NO;
            [arr addObject:localImgs[0]];
            [arr addObject:localImgs[1]];
            [arr insertObject:localImgs[localImgs.count-1] atIndex:0];
            [arr insertObject:localImgs[localImgs.count-2] atIndex:0];
        }
        _localImgs = [arr copy];
        if (_urlImgs.count == 0) {
            _dataImgs = [arr copy];
        }
        [_collectionView reloadData];
        _collectionView.contentOffset = CGPointMake(BannerOffsetWidth*2-BannerOffsetleft, 0);
        _selectedIndex = 0;
        _pageControl.numberOfPages = localImgs.count;
        _pageControl.currentPage = _selectedIndex;
        if (localImgs.count == 1) {
            if (_hidesForSinglePage) {//单张默认隐藏pageControl
                _pageControl.hidden = YES;
            }
            if (_scrollEnabledForSinglePage && _line == 0) {//单张默认无缝轮播图不滚动
                _collectionView.scrollEnabled = NO;
            }
        }
    }
}

- (void)setCurrentPageColor:(UIColor *)currentPageColor
{
    _currentPageColor = currentPageColor;
    _pageControl.currentPageIndicatorTintColor = _currentPageColor;
}
- (void)setNormalPageColor:(UIColor *)normalPageColor
{
    _normalPageColor = normalPageColor;
    _pageControl.pageIndicatorTintColor = _normalPageColor;
    
}
- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage
{
    _hidesForSinglePage = hidesForSinglePage;
    if (_isOne && _hidesForSinglePage) {
        _pageControl.hidden = YES;
    } else {
        _pageControl.hidden = NO;
    }
}
- (void)setScrollEnabledForSinglePage:(BOOL)scrollEnabledForSinglePage
{
    _scrollEnabledForSinglePage = scrollEnabledForSinglePage;
    if (_isOne && _scrollEnabledForSinglePage && _line == 0) {
        _collectionView.scrollEnabled = NO;
    } else {
        _collectionView.scrollEnabled = YES;
    }
}
- (void)setCustomPageControl:(UIPageControl *)customPageControl
{
    _customPageControl = customPageControl;
    if (_pageControl) {
        [_pageControl removeFromSuperview];
    }
    self.pageControl = customPageControl;
    _pageControl.numberOfPages = _dataImgs.count;
    _pageControl.currentPage = _selectedIndex;
    [self addSubview:self.pageControl];
}
- (void)setPageControlFrame:(CGRect)pageControlFrame
{
    _pageControlFrame = pageControlFrame;
    _pageControl.frame = pageControlFrame;
}
- (void)setHidePageControl:(BOOL)hidePageControl
{
    _hidePageControl = hidePageControl;
    _pageControl.hidden = hidePageControl;
}
- (void)setCellCornerRadius:(CGFloat)cellCornerRadius
{
    _cellCornerRadius = cellCornerRadius;
}
#pragma mark 定时器以及自动滚动相关设置
-(void)createTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll
{
    if (_dataImgs.count > 0 && _collectionView.scrollEnabled && _timer) {
        if ([self scrollViewBorderJudge]) {//定时器控制滚动
            NSInteger index = (NSInteger)((_collectionView.contentOffset.x+_line+_showLine)/BannerOffsetWidth);
            [_collectionView setContentOffset:CGPointMake(BannerOffsetWidth*(index+1)-BannerOffsetleft, 0.0) animated:YES];
            _selectedIndex = index-1;
            _pageControl.currentPage = _selectedIndex;
        }
    }
}
- (void)invalidateTimer {
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
}

-(void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    
    [self invalidateTimer];
    if (_autoScroll) {
        [self createTimer];
    }
}
- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval {
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self setAutoScroll:self.autoScroll];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self scrollViewBorderJudge];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    scrollView.scrollEnabled = YES;
    if (self.autoScroll) {
        [self createTimer];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    scrollView.scrollEnabled = NO;
    CGFloat OffsetIndex = (scrollView.contentOffset.x+_line+_showLine)/BannerOffsetWidth;
    NSInteger index = (NSInteger)((scrollView.contentOffset.x+_line+_showLine)/BannerOffsetWidth);
    
    CGPoint offset;
    if (targetContentOffset->x > 0) {// <- 向左滚动
        if ((NSInteger)(OffsetIndex*100)%100 > 50 || ABS(velocity.x) > 0.7) {
            offset = CGPointMake(BannerOffsetWidth*(index+1)-BannerOffsetleft, 0.0);
            _selectedIndex = index-1;
        } else {
            offset = CGPointMake(BannerOffsetWidth*index-BannerOffsetleft, 0.0);
            _selectedIndex = index-2;
        }
    } else {// -> 向右滚动
        if ((NSInteger)(OffsetIndex*100)%100 < 50 || ABS(velocity.x) > 0.7) {
            offset = CGPointMake(BannerOffsetWidth*index-BannerOffsetleft, 0.0);
            _selectedIndex = index-2;
        } else {
            offset = CGPointMake(BannerOffsetWidth*(index+1)-BannerOffsetleft, 0.0);
            _selectedIndex = index-1;
        }
    }
    _pageControl.currentPage = _selectedIndex;
    *targetContentOffset = offset;
}

#pragma mark 边界以及cell位置处理
//处理边界条件 返回YES代表未触发边界条件,且满足_dataImgs.count > 0
- (BOOL)scrollViewBorderJudge
{
    if (_dataImgs.count > 0) {
        if (_collectionView.contentOffset.x <= BannerOffsetWidth*1-BannerOffsetleft) {//左侧边界(正数第二个)->倒数第三个
            _collectionView.contentOffset = CGPointMake(BannerOffsetWidth*(_dataImgs.count-3)-BannerOffsetleft, 0);
            _selectedIndex = _dataImgs.count-5;
            _pageControl.currentPage = _selectedIndex;
            return NO;
        } else if (_collectionView.contentOffset.x >= BannerOffsetWidth*(_dataImgs.count-2)-BannerOffsetleft) {//右侧边界(倒数第二个)->正数第三个
            _collectionView.contentOffset = CGPointMake(BannerOffsetWidth*2-BannerOffsetleft, 0);
            _selectedIndex = 0;
            _pageControl.currentPage = _selectedIndex;
            return NO;
        }
        return YES;
    }
    return NO;
}
    
@end










#define BannerOffsetWidth (self.itemSize.width+self.line)//每次移动偏移量
#define ZoomFactor ABS(1-self.zoom) //缩放比例系数

@interface BannerLayout()

@property (nonatomic, assign) CGFloat line;
@property (nonatomic, assign) CGFloat zoom;
@end

@implementation BannerLayout

- (instancetype)initLine:(CGFloat)line itemSize:(CGSize)itemSize zoom:(CGFloat)zoom
{
    if (self = [super init]) {
        
        self.line = line;
        self.zoom = zoom;
        self.itemSize = itemSize;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = line;
    }
    return self;
}
//允许更新位置
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UICollectionViewLayoutAttributes* attributes = (UICollectionViewLayoutAttributes *)obj;
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normalizedDistance = ABS(distance/BannerOffsetWidth);
        CGFloat zoom = 1 - ZoomFactor*normalizedDistance;
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
        attributes.zIndex = 1;
    }];
    return array;
}

@end



#define PageW 14 // 圆点宽
#define PageH 2  // 圆点高
#define CurrentW 75 // 当前圆点宽
#define CurrentH 2  // 当前圆点高
#define PageLine 5 // 圆点间距

@implementation BannerPageControl

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.userInteractionEnabled = NO;
    
    CGFloat allW = (self.subviews.count - 1)*(PageW+PageLine)+CurrentW;
    CGFloat originX = self.frame.size.width/2-allW/2;
    for (int i = 0; i < self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        if (i == self.currentPage) {//当前page
            view.frame = CGRectMake(originX+ i*(PageW+PageLine), view.frame.origin.y, CurrentW, CurrentH);
        } else if (i > self.currentPage) {
            view.frame = CGRectMake(originX+ i * (PageW+PageLine)+(CurrentW-PageW), view.frame.origin.y, PageW, PageH);
        } else {
            view.frame = CGRectMake(originX+ i * (PageW+PageLine), view.frame.origin.y, PageW, PageH);
        }
        
        view.layer.cornerRadius = 1;
        view.layer.masksToBounds = YES;
    }
}
@end



@implementation BannerCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).offset(0);
            make.height.mas_equalTo(30);
        }];
        
        
    }
    return self;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
    }
    return _imageView;
}
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = AppFont(18);
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.text  =@"";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor=AppAlphaColor(0, 0, 0, 0.5);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
@end
