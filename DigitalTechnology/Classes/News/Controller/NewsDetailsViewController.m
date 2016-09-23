//
//  NewsDetailsViewController.m
//  DigitalTechnology
//
//  Created by qingyun on 16/8/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "NewsDetailsViewController.h"

@interface NewsDetailsViewController ()<UIWebViewDelegate>

@property (nonatomic,weak)UIWebView *webView;
@property (nonatomic,strong)UIActivityIndicatorView *loadingView;
@end

@implementation NewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]init];
    self.view = webView;
    _webView = webView;
    [self loadWebView];
    self.navigationItem.title = @"详情";
}
- (void)loadWebView{
    NSURL *url = [NSURL URLWithString:self.urlWeb];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView.delegate = self;
    [_webView loadRequest:request];

}
#pragma mark UIWebViewDegelate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [ _webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('RelatedRead')[0].style.display = 'none';"];
    [ _webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('m-box')[0].style.display = 'none';"];
    [ _webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('m-box')[1].style.display = 'none';"];
    [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('m-artpro')[0].style.display = 'none';"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@",error);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
      return YES;
}

@end
