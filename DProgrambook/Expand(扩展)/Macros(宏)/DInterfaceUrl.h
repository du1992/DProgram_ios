//
//  DInterfaceUrl.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/23.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <BmobSDK/BmobConfig.h>
NS_ASSUME_NONNULL_BEGIN


#pragma mark - Url链接

/* ========================================= 模拟Url ===========================================================*/






//只处理正确的数据
typedef void (^OutputParamHandler)(id rsp);

//处理服务器返回的错误
typedef void (^ErrorCodeHandler)(NSError *error);


@interface DInterfaceUrl : NSObject

//用户信息
+(void)userPopupWindowBlock:(BmobBooleanResultBlock)block;

//获取随机名字
+(NSString*)getNameString;

//获取随机头像ID
+(NSString*)getUserLogoString;

//获取随机头像
+(NSString*)getImgString:(NSString*)imgId;




@end

NS_ASSUME_NONNULL_END
