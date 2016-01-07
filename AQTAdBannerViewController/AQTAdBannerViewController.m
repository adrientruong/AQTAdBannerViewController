//
//  AQTAdBannerViewController.m
//  Grades
//
//  Created by Adrien Truong on 11/6/15.
//  Copyright © 2015 Adrien Truong. All rights reserved.
//

#import "AQTAdBannerViewController.h"
#import <Flurry.h>

const NSTimeInterval AQTAdBannerAnimationDuration = 0.25;

@interface AQTAdBannerViewController ()

@property (nonatomic, weak) UIView *bannerContainerView;
@property (nonatomic, assign) BOOL installedContentView;
@property (nonatomic, strong) NSLayoutConstraint *bannerContainerViewHeightConstraint;
@property (nonatomic, strong) NSArray *bannerContainerViewVerticalConstraints;

@property (nonatomic, weak) NSLayoutConstraint *bannerViewWidthConstraint;
@property (nonatomic, weak) NSLayoutConstraint *bannerViewHeightConstraint;

@end

@implementation AQTAdBannerViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) {
        return nil;
    }
    
    self.showsAds = YES;
    self.bannerPosition = AQTBannerPositionBottom;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *bannerContainerView = [[UIView alloc] init];
    bannerContainerView.clipsToBounds = YES;
    bannerContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    bannerContainerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bannerContainerView];
    NSDictionary *view = NSDictionaryOfVariableBindings(bannerContainerView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bannerContainerView]|" options:0 metrics:nil views:view]];
    
    self.bannerContainerView = bannerContainerView;
    
    if (self.showsAds) {
        [self installBannerView];
    }
    
    if (self.contentViewController) {
        [self installContentView];
    }
    [self updateBannerConstraintsDependentOnPosition];
    [self toggleBannerVisibilityIfNeededAnimated:NO];
}

- (void)loadBannerView
{
    NSAssert(NO, @"Subclass must implement loadAdBannerView");
}

- (__kindof UIView *)bannerView
{
    if (!_bannerView) {
        [self loadBannerView];
    }
    
    return _bannerView;
}

- (BOOL)isBannerViewInstalled
{
    return (_bannerView.superview != nil);
}

- (void)installBannerView
{
    UIView *bannerView = self.bannerView;
    [self.bannerContainerView addSubview:bannerView];
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *view = NSDictionaryOfVariableBindings(bannerView);
    [self.bannerContainerView addConstraint:[NSLayoutConstraint constraintWithItem:self.bannerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.bannerContainerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.bannerContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bannerView]" options:0 metrics:nil views:view]];
}

- (void)removeBannerView
{
    if ([self isBannerViewInstalled]) {
        [self.bannerView removeFromSuperview];
    }
}

#pragma mark - Controlling whether to show ads or not

- (void)setShowsAds:(BOOL)showsAds
{
    if (_showsAds == showsAds) {
        return;
    }
    
    _showsAds = showsAds;
    
    if (self.isViewLoaded) {
        if (self.showsAds) {
            [self installBannerView];
        }
        
        [self toggleBannerVisibilityIfNeededAnimated:YES completion:^{
            if (!self.showsAds) {
                [self removeBannerView];
            }
        }];
    }
}

#pragma mark - Setting Ad Banner Position

- (void)setBannerPosition:(AQTBannerPosition)adBannerPosition
{
    _bannerPosition = adBannerPosition;
    
    if (self.isViewLoaded) {
        [self updateBannerConstraintsDependentOnPosition];
    }
}

#pragma mark - Setting Content View Controller

- (void)setContentViewController:(UIViewController *)contentViewController
{
    if (self.installedContentView) {
        [self.contentViewController willMoveToParentViewController:nil];
        [self.contentViewController.view removeFromSuperview];
        [self.contentViewController removeFromParentViewController];
    }
    
    _contentViewController = contentViewController;
    _contentViewController.definesPresentationContext = YES;
    
    self.installedContentView = NO;
    
    if (self.isViewLoaded) {
        [self installContentView];
    }
}

- (void)installContentView
{
    [self addChildViewController:self.contentViewController];
    
    [self.view insertSubview:self.contentViewController.view atIndex:0];
    UIView *contentView = self.contentViewController.view;
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *view = NSDictionaryOfVariableBindings(contentView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:view]];
    [self updateContentViewConstraintsDependentOnBannerPosition];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    [self.contentViewController didMoveToParentViewController:self];
    
    self.installedContentView = YES;
}

- (BOOL)shouldShowBanner
{
    return (self.showsAds && [self isBannerLoaded]);
}

- (BOOL)isBannerLoaded
{
    return NO;
}

#pragma mark - Constraints

- (void)updateBannerConstraintsDependentOnPosition
{
    [self.view removeConstraints:self.bannerContainerViewVerticalConstraints];
    
    UIView *bannerContainerView = self.bannerContainerView;
    id <UILayoutSupport> topLayoutGuide = self.topLayoutGuide;
    id <UILayoutSupport> bottomLayoutGuide = self.bottomLayoutGuide;
    NSDictionary *views = NSDictionaryOfVariableBindings(bannerContainerView, topLayoutGuide, bottomLayoutGuide);
    if (self.bannerPosition == AQTBannerPositionTop) {
        self.bannerContainerViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide][bannerContainerView]" options:0 metrics:nil views:views];
    } else {
        self.bannerContainerViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bannerContainerView][bottomLayoutGuide]" options:0 metrics:nil views:views];
    }
    [self.view addConstraints:self.bannerContainerViewVerticalConstraints];
}

- (void)updateContentViewConstraintsDependentOnBannerPosition
{
    UIView *bannerContainerView = self.bannerContainerView;
    UIView *contentView = self.contentViewController.view;
    NSDictionary *views = NSDictionaryOfVariableBindings(bannerContainerView, contentView);
    if (self.bannerPosition == AQTBannerPositionTop) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bannerContainerView][contentView]|" options:0 metrics:nil views:views]];
    } else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView][bannerContainerView]" options:0 metrics:nil views:views]];
    }
}

- (void)toggleBannerVisibilityIfNeededAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (animated) {
        [self.view layoutIfNeeded];
    }
    
    CGFloat height = 0;
    if ([self shouldShowBanner]) {
        height = [self bannerSize].height;
    }
    
    if (self.bannerContainerViewHeightConstraint) {
        self.bannerContainerViewHeightConstraint.constant = height;
    } else {
        self.bannerContainerViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.bannerContainerView                                 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
        [self.bannerContainerView addConstraint:self.bannerContainerViewHeightConstraint];
    }
    
    if (animated) {
        [UIView animateWithDuration:AQTAdBannerAnimationDuration animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    } else {
        [self.view layoutIfNeeded];
    }
}

- (BOOL)isBannerVisible
{
    return self.bannerContainerViewHeightConstraint.constant != 0 && [self isBannerViewInstalled];
}

- (void)toggleBannerVisibilityIfNeededAnimated:(BOOL)animated
{
    [self toggleBannerVisibilityIfNeededAnimated:animated completion:nil];
}

- (CGSize)bannerSize
{
    return [self.bannerView intrinsicContentSize];
}

- (void)updateBannerViewSizeConstraints
{
    CGSize bannerSize = [self bannerSize];
    if (CGSizeEqualToSize(bannerSize, CGSizeZero)) {
        if (self.bannerViewWidthConstraint) {
            [self.bannerContainerView removeConstraint:self.bannerViewWidthConstraint];
            [self.bannerContainerView removeConstraint:self.bannerViewHeightConstraint];
        }
    } else {
        if (!self.bannerViewWidthConstraint) {
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.bannerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:bannerSize.width];
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.bannerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:bannerSize.height];
            
            self.bannerViewWidthConstraint = widthConstraint;
            self.bannerViewHeightConstraint = heightConstraint;
            
            [self.bannerContainerView addConstraint:self.bannerViewWidthConstraint];
            [self.bannerContainerView addConstraint:self.bannerViewHeightConstraint];
        } else {
            self.bannerViewWidthConstraint.constant = bannerSize.width;
            self.bannerViewHeightConstraint.constant = bannerSize.height;
        }
    }
}

- (void)updateBannerViewSizeAnimated:(BOOL)animated;
{
    if (animated) {
        [self.view layoutIfNeeded];
        
        [self updateBannerViewSizeConstraints];
        
        [UIView animateWithDuration:AQTAdBannerAnimationDuration animations:^{
            [self.view layoutIfNeeded];
        }];
    } else {
        [self updateBannerViewSizeConstraints];
    }
}


#pragma mark - Banner View Call Backs

- (void)bannerViewDidLoadAd
{
    [self updateBannerViewSizeAnimated:[self isBannerVisible]];
    [self toggleBannerVisibilityIfNeededAnimated:YES];
}

- (void)bannerViewDidFailToReceiveAdWithError:(NSError *)error
{
    [self toggleBannerVisibilityIfNeededAnimated:YES];
}

@end
