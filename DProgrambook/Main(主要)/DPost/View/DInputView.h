//
//  DInputView.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/11.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"
#define MaxTextViewHeight 80 //限制文字输入的高度
NS_ASSUME_NONNULL_BEGIN

@interface DInputView : DView

//------ 发送文本 -----//
@property (nonatomic,copy) void (^TextViewBlock)(NSString *text);
//------  设置占位符 ------//
- (void)setPlaceholderText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
