//
//  AQTiADBannerViewController.m
//  Grades
//
//  Created by Adrien Truong on 12/2/15.
//  Copyright © 2015 Adrien Truong. All rights reserved.
//

#import "AQTiADBannerViewController.h"
@import iAd;

@interface AQTiADBannerViewController () <ADBannerViewDelegate>

@end

@implementation AQTiADBannerViewController

- (BOOL)isBannerLoaded
{
    ADBannerView *bannerView = self.bannerView;
    return bannerView.isBannerLoaded;
}

- (void)loadBannerView
{
    ADBannerView *bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    bannerView.delegate = self;
    
    self.bannerView = bannerView;
}

#pragma mark - ADBannerViewDelegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self bannerViewDidLoadAd];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self bannerViewDidFailToReceiveAdWithError:error];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

@end
