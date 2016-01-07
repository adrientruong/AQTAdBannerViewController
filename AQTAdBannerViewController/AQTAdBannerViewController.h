// AQTAdBannerViewController.h
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
