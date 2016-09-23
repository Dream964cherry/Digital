//
//  CarouselFigureDetailsViewController.m
//  DigitalTechnology
//
//  Created by qingyun on 16/9/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "CarouselFigureDetailsViewController.h"
#import "FocusModel.h"

@interface CarouselFigureDetailsViewController () <UIWebViewDelegate>
{
    UIWebView *_picsWebView;
}

@end

@implementation CarouselFigureDetailsViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    UIWebView *picsWebView = [[UIWebView alloc]init];
    
    self.view = picsWebView;
    _picsWebView = picsWebView;
    [self loadWebView];

}
- (void)loadWebView{
    NSURL *url = [NSURL URLWithString:self.picsUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _picsWebView.delegate = self;
    [_picsWebView loadRequest:request];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('olTxtTit')[0].style.display = 'none';"];

    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('olTxt')[0].style.display = 'none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('m-box')[0].style.display = 'none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('m-box')[1].style.display = 'none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('RelatedRead')[0].style.display = 'none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('m-artpro')[0].style.display = 'none';"];
}
@end
