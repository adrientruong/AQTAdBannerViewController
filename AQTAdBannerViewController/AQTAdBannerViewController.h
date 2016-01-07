//
//  AQTAdBannerViewController.h
//  Grades
//
//  Created by Adrien Truong on 11/6/15.
//  Copyright © 2015 Adrien Truong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AQTBannerPosition) {
    AQTBannerPositionTop,
    AQTBannerPositionBottom
};

@interface AQTAdBannerViewController : UIViewController

@property (nonatomic, strong) UIViewController *contentViewController;
@property (nonatomic, assign) AQTBannerPosition bannerPosition;
@property (nonatomic, assign) BOOL showsAds;
@property (nonatomic, strong) __kindof UIView *bannerView;

- (BOOL)isBannerViewInstalled;

- (CGSize)bannerSize;

- (void)loadBannerView;
- (void)installBannerView;
- (void)removeBannerView;

- (void)bannerViewDidLoadAd;
- (void)bannerViewDidFailToReceiveAdWithError:(NSError *)error;

@end
