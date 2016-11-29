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





#define Margin  5
#define Padding 10
#define iOS7TopMargin 64 //导航栏44，状态栏20
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define ButtonHeight 44
#define NavigationBarHeight 44

#define APPID_VALUE           @"580487e1"
#define URL_VALUE             @""                 // url
#define TIMEOUT_VALUE         @"20000"            // timeout      连接超时的时间，以ms为单位
#define BEST_URL_VALUE        @"1"                // best_search_url 最优搜索路径

#define SEARCH_AREA_VALUE     @"安徽省合肥市"
#define ASR_PTT_VALUE         @"1"
#define VAD_BOS_VALUE         @"5000"
#define VAD_EOS_VALUE         @"1800"
#define PLAIN_RESULT_VALUE    @"1"
#define ASR_SCH_VALUE         @"1"

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
