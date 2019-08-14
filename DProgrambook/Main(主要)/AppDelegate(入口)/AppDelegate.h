//
//  AppDelegate.h
//  SIXRichEditor
//
//  Created by  on 2018/7/29.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDTSplashAd.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,GDTSplashAdDelegate>

+ (instancetype)sharedAppDelegate;

- (void)enterMainUI;

@property (strong, nonatomic) UIWindow *window;


@end

