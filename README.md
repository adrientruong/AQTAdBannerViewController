# AQTAdBannerViewController
A container view controller for adding banner ads to your app. It handles hiding and showing the banner ad as well as animating this change for you.

## Installing
Add one of these to your Podfile:

Core (abstract base class to subclass to add custom ad banners):
```
pod 'AQTAdBannerViewController'
```  
iAd:
```
pod 'AQTAdBannerViewController/iAd'
```
  
MoPub:
```
pod 'AQTAdBannerViewController/MoPub'
```
  
## Usage

```objective-c
// iAd
AQTiAdBannerViewController *bannerViewController = [[AQTiAdBannerViewController alloc] init];

// or MoPub
AQTMoPubBannerViewController *bannerViewController = [[AQTMoPubBannerViewController alloc] initWithAdUnitID:@"<your ad unit id>"];

UIViewController *contentViewController = [[UIViewController alloc] init];
bannerViewController.contentViewController = contentViewController;

// toggling ads
bannerViewController.showsAds = NO;

// changing position of banner
bannerViewController.bannerPosition = AQTBannerPositionBottom;
```
