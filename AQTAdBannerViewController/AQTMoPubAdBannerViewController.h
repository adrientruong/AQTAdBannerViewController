//
//  AQTMoPubAdBannerViewController.h
//  Grades
//
//  Created by Adrien Truong on 12/2/15.
//  Copyright © 2015 Adrien Truong. All rights reserved.
//

#import "AQTAdBannerViewController.h"

@interface AQTMoPubAdBannerViewController : AQTAdBannerViewController

/**
 @abstract A string representing the ad unit ID to use.
 */
@property (nonatomic, readonly) NSString *adUnitID;

/**
 @abstract Initializes an AQTMoPubAdBannerViewController with the gven ad unit ID
 @returns An initialized AQTMoPubAdBannerViewController
 */
- (instancetype)initWithAdUnitID:(NSString *)adUnitID;

@end
