//
//  DTabBarViewController.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/7/31.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "DTabBarViewController.h"
#import "DNavigationController.h"
#import "DProblemViewController.h"
#import "DBookViewController.h"
#import "DNewsViewController.h"
#import "DPostViewController.h"

@interface DTabBarViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) NSMutableArray * tabbarbuttonArray;

@property (nonatomic, strong) AVAudioPlayer*audioPlayer;

@end

@implementation DTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initializeTabBarController];
}
//初始化
-(void)initializeTabBarController{
   
    //书籍
    DBookViewController *bookVC = [[DBookViewController alloc]init];
    DNavigationController *bookNav =[self controller:bookVC Title:@"书籍" tabBarItemImage:@"book" tabBarItemSelectedImage:@"bookSelected"];
    
    //题库
    DProblemViewController*carClubVC=[[DProblemViewController alloc]init];
    DNavigationController *carClubNav =[self controller:carClubVC Title:@"题库" tabBarItemImage:@"Problem" tabBarItemSelectedImage:@"ProblemSelected"];
    
    //资讯
    DNewsViewController*newsVC=[[DNewsViewController alloc]init];
    DNavigationController *newsbNav =[self controller:newsVC Title:@"资讯" tabBarItemImage:@"forum" tabBarItemSelectedImage:@"forumSelected"];
    
    
    //个人界面
    DPostViewController *meVC = [[DPostViewController alloc] init];
    DNavigationController *meNav = [self controller:meVC Title:@"我的" tabBarItemImage:@"my" tabBarItemSelectedImage:@"mySelected"];
    
    self.viewControllers = @[bookNav,carClubNav,newsbNav,meNav];
    
    [self dropShadowWithOffset:CGSizeMake(0, -1)
                        radius:2
                         color:UIColorFromRGBValue(0x9c9c9c)
                       opacity:0.3];
   
    self.tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [_tabbarbuttonArray addObject:tabBarButton];
        }
    }
}
/**
 * 抽取成一个方法
 * 传入控制器、标题、正常状态下图片、选中状态下图片
 * 直接调用这个方法就可以了
 */
- (DNavigationController*)controller:(UIViewController *)controller Title:(NSString *)title tabBarItemImage:(NSString *)image tabBarItemSelectedImage:(NSString *)selectedImage
{
    DNavigationController *navVC = [[DNavigationController alloc]initWithRootViewController:controller];
    
    navVC.title = title;
    navVC.tabBarItem.image = [UIImage imageNamed:image];
    
    UIImage *imageHome = [UIImage imageNamed:selectedImage];
    imageHome = [imageHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [navVC.tabBarItem setSelectedImage:imageHome];
    
    [navVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:10],
                                               NSForegroundColorAttributeName :UIColorFromRGBValue(0x37A7EF)
                                               } forState:UIControlStateSelected];
    
    [navVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:10],
                                               NSForegroundColorAttributeName : UIColorFromRGBValue(0xbababa)
                                               } forState:UIControlStateNormal];
    
//    [navVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -5)];
//    navVC.tabBarItem.imageInsets = UIEdgeInsetsMake(-4, 0, 4, 0);
    
    return navVC;
    
}

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
    
    self.tabBar.backgroundColor=[UIColor whiteColor];
    self.tabBar.barTintColor = AppColor(255, 255, 255);
    self.tabBar.translucent = YES;
    self.tabBar.alpha = 0.90;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
}

//底部按钮动画
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [tabBar.items indexOfObject:item];
    [self animationWithIndex:index];
   
    
}
// 动画声音
- (void)animationWithIndex:(NSInteger)index{
    
    //底部按钮音效
    NSString*voice=[NSString stringWithFormat:@"voice%ld.mp3",(long)index];
    NSURL *moveMP3=[NSURL fileURLWithPath:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:voice]];
    NSError *err=nil;
    _audioPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:moveMP3 error:&err];
    _audioPlayer.volume=0.5;
    [_audioPlayer prepareToPlay];
    if (err!=nil) {
        NSLog(@"move player init error:%@",err);
    }else {
        [_audioPlayer play];
    }
    
    //底部按钮特效
    NSLog(@"点击====%ld",(long)index);
    UIView *tabBarButton =_tabbarbuttonArray[index];
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    
    [[tabBarButton layer]  addAnimation:pulse forKey:nil];
    
  
    
}
@end
