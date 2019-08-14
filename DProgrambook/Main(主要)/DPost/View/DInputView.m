//
//  DInputView.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/11.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DInputView.h"

@interface DInputView()<UITextViewDelegate,UIScrollViewDelegate>
{
    BOOL statusTextView;//当文字大于限定高度之后的状态
    NSString *placeholderText;//设置占位符的文字
}
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UIButton *sendButton;
@end


@implementation DInputView

- (void)setLayout{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)name:UIKeyboardWillHideNotification
                                               object:nil];
    /**
     点击 空白区域取消
     */
    UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
    [self addGestureRecognizer:centerTap];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6);
        make.left.mas_equalTo(5);
        make.bottom.mas_equalTo(-6);
        make.width.mas_equalTo(kScreenWidth-65);
    }];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(39);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.right.mas_equalTo(-5);
        make.width.mas_equalTo(50);
    }];
    
}

//暴露的方法
- (void)setPlaceholderText:(NSString *)text{
    placeholderText = text;
    self.placeholderLabel.text = placeholderText;
}


//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    self.frame = kScreenBounds;
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    if (self.textView.text.length == 0) {
        
        self.backGroundView.frame = CGRectMake(0, kScreenHeight-height-49, kScreenWidth, 49);
    }else{
        CGRect rect = CGRectMake(0, kScreenHeight - self.backGroundView.frame.size.height-height, kScreenWidth, self.backGroundView.frame.size.height);
        self.backGroundView.frame = rect;
    }
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (self.textView.text.length == 0) {
        self.backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 49);
        self.frame = CGRectMake(0, kScreenHeight-49, kScreenWidth, 49);
    }else{
        CGRect rect = CGRectMake(0, 0, kScreenWidth, self.backGroundView.frame.size.height);
        self.backGroundView.frame = rect;
        self.frame = CGRectMake(0, kScreenHeight - rect.size.height, kScreenWidth, self.backGroundView.frame.size.height);
    }
}

- (void)centerTapClick{
    [self.textView resignFirstResponder];
}




#pragma mark --- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    /**
     *  设置占位符
     */
    if (textView.text.length == 0) {
        self.placeholderLabel.text = placeholderText;
        [self.sendButton setBackgroundColor:AppColor(180, 180, 180)];
        self.sendButton.userInteractionEnabled = NO;
    }else{
        self.placeholderLabel.text = @"";
        [self.sendButton setBackgroundColor:AppColor(70 , 163, 231)];
        self.sendButton.userInteractionEnabled = YES;
    }
    
    //---- 计算高度 ---- //
    CGSize size = CGSizeMake(kScreenWidth-65, CGFLOAT_MAX);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil];
    CGFloat curheight = [textView.text boundingRectWithSize:size
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:dic
                                                    context:nil].size.height;
    CGFloat y = CGRectGetMaxY(self.backGroundView.frame);
    if (curheight < 19.094) {
        statusTextView = NO;
        self.backGroundView.frame = CGRectMake(0, y - 49, kScreenWidth, 49);
    }else if(curheight < MaxTextViewHeight){
        statusTextView = NO;
        self.backGroundView.frame = CGRectMake(0, y - textView.contentSize.height-10, kScreenWidth,textView.contentSize.height+10);
    }else{
        statusTextView = YES;
        return;
    }
    
}

#pragma  mark -- 发送事件
- (void)sendClick:(UIButton *)sender{
    [self.textView endEditing:YES];
    if (self.TextViewBlock) {
        self.TextViewBlock(self.textView.text);
    }
    
    //---- 发送成功之后清空 ------//
    self.textView.text = nil;
    self.placeholderLabel.text = placeholderText;
    [self.sendButton setBackgroundColor:AppColor(180, 180, 180)];
    self.sendButton.userInteractionEnabled = NO;
    self.frame = CGRectMake(0, kScreenHeight-49, kScreenWidth, 49);
    self.backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 49);
}



#pragma mark --- 懒加载控件
- (UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
        _backGroundView.backgroundColor = AppColor(0, 153, 238);
        [self addSubview:_backGroundView];
    }
    return _backGroundView;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.delegate = self;
        _textView.layer.cornerRadius = 5;
        [self.backGroundView addSubview:_textView];
    }
    return _textView;
}

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.font = [UIFont systemFontOfSize:16];
        _placeholderLabel.textColor = [UIColor grayColor];
        [self.backGroundView addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

- (UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [[UIButton alloc]init];
        [_sendButton setBackgroundColor:AppColor(180, 180, 180)];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
        _sendButton.layer.cornerRadius = 5;
        _sendButton.userInteractionEnabled = NO;
        [self.backGroundView addSubview:_sendButton];
    }
    return _sendButton;
}

#pragma mark --- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (statusTextView == NO) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        
    }
}
@end
