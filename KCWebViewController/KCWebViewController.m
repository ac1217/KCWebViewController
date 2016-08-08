//
//  ViewController.m
//  Example
//
//  Created by zhangweiwei on 16/8/8.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import "KCWebViewController.h"

@interface KCWebViewController ()<WKNavigationDelegate, WKUIDelegate>{
    UIProgressView *_progressView;
}

@end

@implementation KCWebViewController

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (instancetype)initWithURL:(NSURL *)url
{
    if (self = [super init]) {
        self.url = url;
    }
    return self;
}

#pragma mark -Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = self.view.bounds;
    
    self.progressView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, 10);
}

#pragma mark -Private Method
- (void)setupUI
{
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
}

- (void)loadWeb
{
    if (!self.url) return;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    
    [self.webView loadRequest:request];
    
}

- (void)setUrl:(NSURL *)url
{
    _url = url;
    
    [self loadWeb];
}

- (void)setAllowsBackForwardNavigationGestures:(BOOL)allowsBackForwardNavigationGestures
{
    _allowsBackForwardNavigationGestures = allowsBackForwardNavigationGestures;
    
    self.webView.allowsBackForwardNavigationGestures = allowsBackForwardNavigationGestures;
}

#pragma mark-Event
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    double progeress  = [change[NSKeyValueChangeNewKey] doubleValue];
    self.progressView.progress = progeress ;
    self.progressView.hidden = NO;
}


#pragma mark -WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    self.title = webView.title;
    
    self.progressView.hidden = YES;
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    self.progressView.hidden = NO;
}


-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    self.progressView.hidden = YES;
}


#pragma mark -getter
- (WKWebView *)webView
{
    if (!_webView) {
        
        _webView  = [[WKWebView alloc] init];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        
        _webView.allowsBackForwardNavigationGestures = self.allowsBackForwardNavigationGestures;
        //    kvo监听进度
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
        if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
            
            _webView.allowsLinkPreview = YES;
        }
#endif
    }
    return _webView;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.hidden = YES;
    }
    return _progressView;
}



@end
