//
//  DBookManager.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/2.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBookManager.h"

static DBookManager *_defaultManager = nil;

@implementation DBookManager

+(instancetype)defaultManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultManager=[DBookManager initializeData];
    });
    return _defaultManager;
}
//初始化数据
+(DBookManager*)initializeData{
    
    id input=DUserDefaultsGET(kDiscuss);
    if (input) {
      return  [DBookManager mj_objectWithKeyValues:input];
    }else{
        DBookManager*defaultManager = [[DBookManager alloc]init];
    defaultManager.colorArray=@[@"CBECD1",@"EBEBEB",@"E5C8C8",@"FFE7BA",@"90EE90",@"20B2AA", @"191919",@"FFFFFF"];
        
        defaultManager.fontSizeSelected=20;
        return defaultManager;
        
    }
}



- (void) setIsMoon:(BOOL)isMoon{
    if (_isMoon!=isMoon) {
        _isMoon = isMoon;
        id input=[self mj_keyValues];
        DUserDefaultsSET(input,kDiscuss);
    }
   
}

- (void) setFontSizeSelected:(NSUInteger)fontSizeSelected{
    if (_fontSizeSelected!=fontSizeSelected) {
        _fontSizeSelected=fontSizeSelected;
        id input=[self mj_keyValues];
        DUserDefaultsSET(input,kDiscuss);
    }
    
}



- (void) setBgColorSelected:(NSUInteger)bgColorSelected{
    if (_bgColorSelected != bgColorSelected) {
        _bgColorSelected = bgColorSelected;
        id input=[self mj_keyValues];
        DUserDefaultsSET(input,kDiscuss);
    }
    
}


-(void)refreshBookModel:(DBookModel*)model{
     self.imageName=model.imageName;
     self.bookID=model.bookID;
     self.titleString=model.titleString;
     self.introduction=model.introduction;
     self.chapterArray=model.chapterArray;
    id input=[self mj_keyValues];
    DUserDefaultsSET(input,kDiscuss);
}
-(void)refreshBookTxtModel:(DBookTxtModel*)model index:(NSInteger)index{
    self.index=index;
    self.cellHeight=model.cellHeight;
    self.title=model.title;
    self.txt=model.txt;
    id input=[self mj_keyValues];
    DUserDefaultsSET(input,kDiscuss);
    
}
/*获取背景颜色*/
-(NSString*)getbgColor{
    if (self.isMoon) {
        return @"191919";
    }
    NSString*color=self.colorArray[self.bgColorSelected];
    return color;
    
}
/*获取标题字号*/
-(UIFont *)getTitleFontSize{
   return  [UIFont systemFontOfSize:self.fontSizeSelected+5];
}
/*获取内容字号*/
-(UIFont *)getTxtFontSize{
    return [UIFont systemFontOfSize:self.fontSizeSelected];
}
@end
