//
//  MAXBannerAdVC.h
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import <AppLovinSDK/AppLovinSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAXBannerAdVC : UIViewController <MAAdViewAdDelegate>

// Ad View Customizations
@property (nonatomic, copy) NSString *adConfigId;
@property (nonatomic, assign) CGSize adSize;
@property (nonatomic, strong) MAAdFormat *adFormat;
@property (nonatomic, assign) BOOL isAutoRefreshEnabled;
@property (nonatomic, assign) BOOL isAdaptive;

@end

NS_ASSUME_NONNULL_END
