//
//  MAXRewardedAdVC.h
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import <AppLovinSDK/AppLovinSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAXRewardedAdVC : UIViewController <MARewardedAdDelegate>

// Ad View Customizations
@property (nonatomic, copy) NSString *adConfigId;

@end

NS_ASSUME_NONNULL_END
