//
//  AQTAdBannerViewController.h
//  Grades
//
//  Created by Adrien Truong on 11/6/15.
//  Copyright © 2015 Adrien Truong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @typedef AQTBannerPosition
 @brief A list of banner positions.
 @constant AQTBannerPositionTop Specifies that the ad should be placed at the top of the view.
 @constant AQTBannerPositionBottom Specifies that the ad should be placed at the bottom of the view.
 */
typedef NS_ENUM(NSInteger, AQTBannerPosition) {
    AQTBannerPositionTop,
    AQTBannerPositionBottom
};

/**
 `AQTAdBannerViewController` is an abstract container view controller class that has support for displaying ad banners.
 */

@interface AQTAdBannerViewController : UIViewController

/**
 The view controller to display alongside the banner.
 */
@property (nonatomic, strong) UIViewController *contentViewController;

/*
 Specifies where to position the banner ad.
 */
@property (nonatomic, assign) AQTBannerPosition bannerPosition;

/*
 A boolean value indicating whether the view controller shows ads.
 */
@property (nonatomic, assign) BOOL showsAds;

/**
 A UIView which contains the banner ad.
 */
@property (nonatomic, strong) __kindof UIView *bannerView;

/**
 @return A boolean value indicating whether the banner view is currently in the view hierarchy.
 */
- (BOOL)isBannerViewInstalled;

/**
 @abstract This method can used to specify the size of the banner so that the view controller can handle layout correctly. By default, it returns the intrinsicContentSize of `bannerView`.
 @return
 */
- (CGSize)bannerSize;

/**
 @abstract Creates the banner view that the view controller shows.
 */
- (void)loadBannerView;

/**
 @abstract Adds the banner view to the view hierarchy.
 */
- (void)installBannerView;

/**
 @abstract Removes the banner view from the view hierarchy.
 */
- (void)removeBannerView;

/**
 @abstract Subclasses should call this method when the banner view has finished loading an ad and is ready to display it to the user.
 */
- (void)bannerViewDidLoadAd;

/**
 @abstract Subclasses should call this method when the banner view has failed to load an ad and does not have an ad to display to the user
 */
- (void)bannerViewDidFailToReceiveAdWithError:(NSError *)error;

@end
