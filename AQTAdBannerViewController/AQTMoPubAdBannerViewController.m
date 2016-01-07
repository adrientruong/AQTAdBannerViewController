//
//  AQTMoPubAdBannerViewController.m
//  Grades
//
//  Created by Adrien Truong on 12/2/15.
//  Copyright © 2015 Adrien Truong. All rights reserved.
//

#import "AQTMoPubAdBannerViewController.h"
#import <MPAdView.h>

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
