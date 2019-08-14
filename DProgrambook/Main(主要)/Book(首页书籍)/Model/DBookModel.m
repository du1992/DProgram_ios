//
//  DBookModel.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/1.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBookModel.h"

@implementation DBookModel

/**数据处理**/
-(void)modelDealWith:(BmobObject *)obj{
    
    self.titleString        = [obj objectForKey:@"title"];
    self.imageName          = [obj objectForKey:@"cover"];
    self.author             = [obj objectForKey:@"author"];
    self.introduction       = [obj objectForKey:@"Introduction"];
    self.bookID             = [obj objectForKey:@"objectId"];
    self.chapterArray       = [obj objectForKey:@"chapterArray"];
}





@end
