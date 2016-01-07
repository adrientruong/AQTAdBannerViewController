//
//  AQTMoPubAdBannerViewController.h
//  Grades
//
//  Created by Adrien Truong on 12/2/15.
//  Copyright © 2015 Adrien Truong. All rights reserved.
//

#import "AQTAdBannerViewController.h"

@interface AQTMoPubAdBannerViewController : AQTAdBannerViewController

@property (nonatomic, readonly) NSString *adUnitID;

- (instancetype)initWithAdUnitID:(NSString *)adUnitID;

@end
