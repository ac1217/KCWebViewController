//
//  ViewController.h
//  Example
//
//  Created by zhangweiwei on 16/8/8.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface KCWebViewController : UIViewController

- (instancetype)initWithURL:(NSURL *)url;

@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong, readonly) UIProgressView *progressView;

@property (nonatomic) BOOL allowsBackForwardNavigationGestures;

@end

