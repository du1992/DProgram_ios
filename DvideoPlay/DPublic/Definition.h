//
//  Definition.h
//  DVoiceSend
//
//  Created by DUCHENGWEN on 2016/10/26.
//  Copyright © 2016年 DCW. All rights reserved.
//

#import <Foundation/Foundation.h>



/*
 ====================================================================================================//打印相关
 */
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)


#else


#define NSLog(...)
#define debugMethod()
#endif
/*
 ====================================================================================================//获取屏幕尺寸
 */

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

/** 屏幕的高度 */
#define HEIGHT [UIScreen mainScreen].bounds.size.height
/** 屏幕的宽度 */
#define WIDTH [UIScreen mainScreen].bounds.size.width

//字体大小

#define kFountBig       [UIFont systemFontOfSize:16]
#define kFountNormal    [UIFont systemFontOfSize:14]
#define kFountTen       [UIFont systemFontOfSize:10]
#define kFountNormalSmall    [UIFont systemFontOfSize:13]
#define kFountEighteen       [UIFont systemFontOfSize:18]

#define kFountSmall  [UIFont systemFontOfSize:12]


/*
 ====================================================================================================//颜色相关1
 */

#define navigationBarColor RGB(67, 199, 176)
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
// 2.获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)
/**  */
#define COLOR_BLACK [UIColor blackColor]
/**  */
#define COLOR_DARKGRAY [UIColor darkGrayColor]
/**  */
#define COLOR_LIGHTGRAY [UIColor lightGrayColor]
/**  */
#define COLOR_WHITE [UIColor whiteColor]
/**  */
#define COLOR_GRAY [UIColor grayColor]
/**  */
#define COLOR_RED [UIColor redColor]
/**  */
#define COLOR_GREEN [UIColor greenColor]
/**  */
#define COLOR_BLUE [UIColor blueColor]
/**  */
#define COLOR_CYAN [UIColor cyanColor]
/**  */
#define COLOR_YELLOW [UIColor yellowColor]
/**  */
#define COLOR_MAGENTA [UIColor magentaColor]
/**  */
#define COLOR_ORANGE [UIColor orangeColor]
/**  */
#define COLOR_PURPLE [UIColor purpleColor]
/**  */
#define COLOR_BROWN [UIColor brownColor]
/**  */
#define COLOR_CLEAR [UIColor clearColor]
/*
 ====================================================================================================//颜色相关2
 */
/**  */
#define BLACK_COLOR [UIColor blackColor]
/**  */
#define DARKGRAY_COLOR [UIColor darkGrayColor]
/**  */
#define LIGHTGRAY_COLOR [UIColor lightGrayColor]
/**  */
#define WHITE_COLOR [UIColor whiteColor]
/**  */
#define GRAY_COLOR [UIColor grayColor]
/**  */
#define RED_COLOR [UIColor redColor]
/**  */
#define GREEN_COLOR [UIColor greenColor]
/**  */
#define BLUE_COLOR [UIColor blueColor]
/**  */
#define CYAN_COLOR [UIColor cyanColor]
/**  */
#define YELLOW_COLOR [UIColor yellowColor]
/**  */
#define MAGENTA_COLOR [UIColor magentaColor]
/**  */
#define ORANGE_COLOR [UIColor orangeColor]
/**  */
#define PURPLE_COLOR [UIColor purpleColor]
/**  */
#define BROWN_COLOR [UIColor brownColor]
/**  */
#define CLEAR_COLOR [UIColor clearColor]
/*
 ====================================================================================================//颜色相关3
 */
#define RGB_COLOR(R,G,B)     [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1]
#define RGBA_COLOR(R,G,B,A)  [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
#define COLOR_RGB(R,G,B)     [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1]
#define COLOR_RGBA(R,G,B,A)  [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
/** 16进制颜色值，如：#000000 , 注意：在使用的时候hexValue写成：0x000000 */
#define HexColor(hexValue)  [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:1.0]

// 视图背景颜色
#define kLineBackGroundGrayColor RGB(230,230,230)
#define kblueColor          RGB(0,168,255)
#define korangeColor        RGB(251,140,38)
#define kYellowColor        RGB(255,226,2)
#define kBlackColor80       RGB(80,40,24)
#define kBlackColor29       RGB(29,29,38)
#define kBlackColor91       RGB(91,91,91)
#define kGrayColor105       RGB(105,105,105)
#define kGrayColor186       RGB(186,186,186)
#define kGrayColor174       RGB(174,174,175)
#define kGrayColor105       RGB(105,105,105)
#define kHomePageBlackColor   RGB(237,237,237)




#define Margin  5
#define Padding 10
#define iOS7TopMargin 64 //导航栏44，状态栏20
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define ButtonHeight 44
#define NavigationBarHeight 44

#define  URL_playURL @"http://ic.snssdk.com/neihan/video/playback/?video_id=63016571739e4328a08928001f7389df&quality=480p&line=0&is_gif=1.mp4"

#ifdef __IPHONE_6_0
# define IFLY_ALIGN_CENTER NSTextAlignmentCenter
#else
# define IFLY_ALIGN_CENTER UITextAlignmentCenter
#endif

#ifdef __IPHONE_6_0
# define IFLY_ALIGN_LEFT NSTextAlignmentLeft
#else
# define IFLY_ALIGN_LEFT UITextAlignmentLeft



#endif
