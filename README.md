# AQTAdBannerViewController
A container view controller for adding banner ads to your app

## Installing
Core:
```bash
$ pod 'AQTAdBannerViewController'
```  
iAd:
```bash
$ pod 'AQTAdBannerViewController/iAd'
```
  
MoPub:
```bash
$ pod 'AQTAdBannerViewController/MoPub'
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
```
