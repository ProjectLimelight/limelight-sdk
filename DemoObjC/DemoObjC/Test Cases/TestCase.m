//
//  TestCase.m
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import "TestCase.h"
#import <LimelightSDK/LimelightSDK.h>
#import "BannerAdVC.h"
#import "InterstitialAdVC.h"
#import "RewardedAdVC.h"
#import "MAXBannerAdVC.h"
#import "MAXInterstitialAdVC.h"
#import "MAXRewardedAdVC.h"

// MARK: - Implementation

@implementation TestCase

- (instancetype)initWithTitle:(NSString *)title
                 storyboardId:(NSString *)storyboardId
         configurationClosure:(nullable void (^)(UIViewController *vc))configurationClosure {
    self = [super init];
    if (self) {
        _title = [title copy];
        _storyboardId = [storyboardId copy];
        _configurationClosure = [configurationClosure copy];
    }
    return self;
}

- (UIViewController *)makeViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:self.storyboardId];
    vc.title = self.title;
    if (self.configurationClosure) {
        self.configurationClosure(vc);
    }
    return vc;
}

+ (NSDictionary<NSString *, NSArray<TestCase *> *> *)testCases {
    return @{
        @"In-App": [self allInAppCases],
        @"AppLovin MAX": [self allAppLovinCases],
    };
}

+ (nullable NSNumber *)indexOfSection:(NSString *)section {
    NSArray<NSString *> *keys = [self testCases].allKeys;
    NSUInteger index = [keys indexOfObject:section];
    return index != NSNotFound ? @(index) : nil;
}

+ (nullable NSString *)sectionKeyOfIndex:(NSInteger)index {
    NSArray<NSString *> *keys = [self testCases].allKeys;
    return (NSInteger)keys.count > index ? keys[index] : nil;
}

// MARK: - In-App Cases

+ (NSArray<TestCase *> *)allInAppCases {
    return [[self banners] arrayByAddingObjectsFromArray:
           [[self interstitials] arrayByAddingObjectsFromArray:
            [self rewarded]]];
}

// MARK: Banners

+ (NSArray<TestCase *> *)banners {
    return @[
        [[TestCase alloc] initWithTitle:@"Banner [320x50]"
                           storyboardId:@"BannerAdVC"
                   configurationClosure:^(UIViewController *vc) {
            BannerAdVC *bannerController = (BannerAdVC *)vc;
            bannerController.adSize = LLAdSize.banner_320x50;
            bannerController.adConfigId = @"123456789";
        }],
        [[TestCase alloc] initWithTitle:@"Banner [300x250]"
                           storyboardId:@"BannerAdVC"
                   configurationClosure:^(UIViewController *vc) {
            BannerAdVC *bannerController = (BannerAdVC *)vc;
            bannerController.adSize = LLAdSize.banner_300x250;
            bannerController.adConfigId = @"123456789";
        }],
    ];
}

// MARK: Interstitials

+ (NSArray<TestCase *> *)interstitials {
    return @[
        [[TestCase alloc] initWithTitle:@"Interstitial [Banner] [320x480]"
                           storyboardId:@"InterstitialAdVC"
                   configurationClosure:^(UIViewController *vc) {
            InterstitialAdVC *interstitialController = (InterstitialAdVC *)vc;
            interstitialController.adFormats = @[LLAdFormat.banner];
            interstitialController.adConfigId = @"123456789";
            interstitialController.adSize = CGSizeMake(320, 480);
        }],
        [[TestCase alloc] initWithTitle:@"Interstitial [Banner] [480x320]"
                           storyboardId:@"InterstitialAdVC"
                   configurationClosure:^(UIViewController *vc) {
            InterstitialAdVC *interstitialController = (InterstitialAdVC *)vc;
            interstitialController.adConfigId = @"123456789";
            interstitialController.adFormats = @[LLAdFormat.banner];
            interstitialController.adSize = CGSizeMake(480, 320);
        }],
        [[TestCase alloc] initWithTitle:@"Interstitial [Video] [480x320]"
                           storyboardId:@"InterstitialAdVC"
                   configurationClosure:^(UIViewController *vc) {
            InterstitialAdVC *interstitialController = (InterstitialAdVC *)vc;
            interstitialController.adConfigId = @"123456789";
            interstitialController.adFormats = @[LLAdFormat.video];
            interstitialController.adSize = CGSizeMake(480, 320);
        }],
        [[TestCase alloc] initWithTitle:@"Interstitial [Banner, Video] [Multi-Imp] [480x320]"
                           storyboardId:@"InterstitialAdVC"
                   configurationClosure:^(UIViewController *vc) {
            InterstitialAdVC *interstitialController = (InterstitialAdVC *)vc;
            interstitialController.adConfigId = @"123456789";
            interstitialController.adFormats = @[LLAdFormat.banner, LLAdFormat.video];
            interstitialController.adSize = CGSizeMake(480, 320);
        }],
    ];
}

// MARK: Rewarded

+ (NSArray<TestCase *> *)rewarded {
    return @[
        [[TestCase alloc] initWithTitle:@"Rewarded [Video] [480x320]"
                           storyboardId:@"RewardedAdVC"
                   configurationClosure:^(UIViewController *vc) {
            RewardedAdVC *rewardedAdController = (RewardedAdVC *)vc;
            rewardedAdController.adConfigId = @"123456789";
            rewardedAdController.adFormats = @[LLAdFormat.video];
            rewardedAdController.adSize = CGSizeMake(480, 320);
        }],
    ];
}

// MARK: - AppLovin MAX Cases

+ (NSArray<TestCase *> *)allAppLovinCases {
    return [[self alBanners] arrayByAddingObjectsFromArray:
           [[self alInterstitials] arrayByAddingObjectsFromArray:
            [self alRewarded]]];
}

// MARK: Banners

+ (NSArray<TestCase *> *)alBanners {
    return @[
        [[TestCase alloc] initWithTitle:@"Banner [320x50]"
                            storyboardId:@"MAXBannerAdVC"
                    configurationClosure:^(UIViewController *vc) {
            MAXBannerAdVC *bannerController = (MAXBannerAdVC *)vc;
            bannerController.adSize = CGSizeMake(320, 50);
            bannerController.adConfigId = @"123456789";
        }],
        [[TestCase alloc] initWithTitle:@"Banner [300x250]"
                            storyboardId:@"MAXBannerAdVC"
                    configurationClosure:^(UIViewController *vc) {
            MAXBannerAdVC *bannerController = (MAXBannerAdVC *)vc;
            bannerController.adSize = CGSizeMake(300, 250);
            bannerController.adConfigId = @"123456789";
        }],
    ];
}

// MARK: Interstitials

+ (NSArray<TestCase *> *)alInterstitials {
    return @[
        [[TestCase alloc] initWithTitle:@"Interstitial"
                            storyboardId:@"MAXInterstitialAdVC"
                    configurationClosure:^(UIViewController *vc) {
            MAXInterstitialAdVC *interstitialController = (MAXInterstitialAdVC *)vc;
            interstitialController.adConfigId = @"123456789";
        }],
    ];
}

// MARK: Rewarded

+ (NSArray<TestCase *> *)alRewarded {
    return @[
        [[TestCase alloc] initWithTitle:@"Rewarded"
                            storyboardId:@"MAXRewardedAdVC"
                    configurationClosure:^(UIViewController *vc) {
            MAXRewardedAdVC *rewardedAdController = (MAXRewardedAdVC *)vc;
            rewardedAdController.adConfigId = @"123456789";
        }],
    ];
}

@end
