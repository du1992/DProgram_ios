//
//  DBookManager.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/2.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBookModel.h"
#import "DBookTxtModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBookManager : NSObject

/*工具单利*/
+(instancetype)defaultManager;


/*------------------------------阅读器的设置缓存------------------------------*/

/*背景颜色列表*/
@property (nonatomic, strong) NSArray     *colorArray;
/*选中的背景颜色*/
@property (nonatomic, assign) NSUInteger    bgColorSelected;
/*选中的字号*/
@property (nonatomic, assign) NSUInteger    fontSizeSelected;
/*是否夜间模式*/
@property (nonatomic, assign) BOOL    isMoon;

/*获取背景颜色*/
-(NSString*)getbgColor;
/*获取标题字号*/
-(UIFont *)getTitleFontSize;
/*获取内容字号*/
-(UIFont *)getTxtFontSize;


/*------------------------------上次阅读书本信息------------------------------*/
/**封面 */
@property(nonatomic, copy) NSString *imageName;
/**ID**/
@property (nonatomic, strong) NSString *bookID;
/**标题*/
@property(nonatomic, copy) NSString *titleString;
/**简介*/
@property(nonatomic, copy) NSString *introduction;
/**章节**/
@property (nonatomic, strong) NSArray *chapterArray;

-(void)refreshBookModel:(DBookModel*)model;

/*------------------------------上次阅读的内容------------------------------*/
/**标题**/
@property (nonatomic, strong) NSString *title;
/**内容**/
@property (nonatomic, strong) NSString *txt;
/**cell高度**/
@property (nonatomic)  NSInteger cellHeight;
/**请求下标**/
@property (nonatomic)  NSInteger index;

-(void)refreshBookTxtModel:(DBookTxtModel*)model index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
