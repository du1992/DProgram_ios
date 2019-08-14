//
//  DWebViewController.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/11.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DWebViewController.h"
#import <WebKit/WebKit.h>
#import "NSTimer+addition.h"

@interface DWebViewController ()<WKNavigationDelegate>
/** 进度条颜色 */
@property (nonatomic, assign) UIColor *progressColor;

@property (nonatomic, strong)WKWebView *webView;

@property (nonatomic, strong)DWebProgressLayer *webProgressLayer;

@end

@implementation DWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = self.newsModel.title;
    
    [self initializeUI];
    [self addBackItem];
}

-(void)initializeUI{
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.navigationDelegate =self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.newsModel.article]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    
    self.webProgressLayer = [[DWebProgressLayer alloc] init];
    self.webProgressLayer.frame = CGRectMake(0, 42,kScreenWidth, 3);
    self.webProgressLayer.strokeColor = AppColor(247, 104, 104).CGColor;
    [self.navigationController.navigationBar.layer addSublayer:self.webProgressLayer];
}

#pragma mark - UIWebViewDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.webProgressLayer tg_startLoad];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.webProgressLayer tg_finishedLoadWithError:nil];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.webProgressLayer tg_finishedLoadWithError:error];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    
 
    
    
    
    
    [self.view hideLoading];
}


- (void)dealloc {
    [self.webProgressLayer tg_closeTimer];
    [_webProgressLayer removeFromSuperlayer];
    _webProgressLayer = nil;
}


@end






static NSTimeInterval const ProgressTimeInterval = 0.03;

@interface DWebProgressLayer()

@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat plusWidth;

@end

@implementation DWebProgressLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initBezierPath];
    }
    return self;
    
}

- (void)initBezierPath {
    //绘制贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    //起点
    [path moveToPoint:CGPointMake(0, 3)];
    //终点
    [path addLineToPoint:CGPointMake(kScreenWidth,3)];
    
    self.path = path.CGPath;
    self.strokeEnd = 0;
    _plusWidth = 0.005;
    self.lineWidth = 2;
    self.strokeColor = [UIColor redColor].CGColor;
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:ProgressTimeInterval target:self selector:@selector(pathChanged:) userInfo:nil repeats:YES];
    [_timer tg_pauseTime];
    
}

// 设置进度条增加的进度
- (void)pathChanged:(NSTimer *)timer{
    self.strokeEnd += _plusWidth;
    if (self.strokeEnd > 0.60) {
        _plusWidth = 0.002;
    }
    
    if (self.strokeEnd > 0.85) {
        _plusWidth = 0.0007;
    }
    
    if (self.strokeEnd > 0.93) {
        _plusWidth = 0;
    }
}

//在KVO 计算  实际的读取进度时,调用改方法
- (void)tg_WebViewPathChanged:(CGFloat)estimatedProgress {
    self.strokeEnd = estimatedProgress;
    
}

- (void)tg_startLoad {
    [_timer tg_webPageTimeWithTimeInterval:ProgressTimeInterval];
    
}

- (void)tg_finishedLoadWithError:(NSError *)error {
    CGFloat timer;
    if (error == nil) {
        [self tg_closeTimer];
        timer = 0.5;
        self.strokeEnd = 1.0;
    }else {
        timer = 45.0;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (timer == 45.0) {
            [self tg_closeTimer];
            
        }
        self.hidden = YES;
        [self removeFromSuperlayer];
        
    });
}

#pragma mark - private
- (void)tg_closeTimer {
    
    [_timer invalidate];
    _timer = nil;
    
}

- (void)dealloc {
    [self tg_closeTimer];
}

@end
