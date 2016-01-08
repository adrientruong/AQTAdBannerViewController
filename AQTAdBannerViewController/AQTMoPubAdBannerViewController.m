// AQTMoPubAdBannerViewController.m
//
// Copyright (c) 2016 Adrien Truong
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
#import "AQTMoPubAdBannerViewController.h"
#import <mopub-ios-sdk/MPAdView.h>

@interface AQTMoPubAdBannerViewController () <MPAdViewDelegate>

@property (nonatomic, assign, getter=isBannerLoaded) BOOL bannerLoaded;

@end

@implementation AQTMoPubAdBannerViewController

- (instancetype)initWithAdUnitID:(NSString *)adUnitID
{
    self = [super initWithNibName:nil bundle:nil];
    if (!self) {
        return nil;
    }
    
    _adUnitID = adUnitID;
    
    return self;
}

- (void)loadBannerView
{
    MPAdView *bannerView = [[MPAdView alloc] initWithAdUnitId:self.adUnitID
                                                size:CGSizeMake(CGRectGetWidth(self.view.frame), MOPUB_BANNER_SIZE.height)];
    [bannerView loadAd];
    
    self.bannerView = bannerView;
}

- (CGSize)bannerSize
{
    MPAdView *bannerView = self.bannerView;
    return [bannerView adContentViewSize];
}

- (void)installBannerView
{
    [super installBannerView];
    
    MPAdView *bannerView = self.bannerView;
    bannerView.delegate = self;
    [bannerView startAutomaticallyRefreshingContents];
}

- (void)removeBannerView
{
    MPAdView *bannerView = self.bannerView;
    bannerView.delegate = nil;
    [bannerView stopAutomaticallyRefreshingContents];
    
    self.bannerLoaded = NO;
    
    [super removeBannerView];
}

#pragma mark - MPAdViewDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)adViewDidLoadAd:(MPAdView *)view
{
    self.bannerLoaded = YES;
    [self bannerViewDidLoadAd];
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view
{
    self.bannerLoaded = NO;
    [self bannerViewDidFailToReceiveAdWithError:nil];
}

@end
