//
//  BannerAdVC.h
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import "LimelightSDK/LimelightSDK-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface BannerAdVC : UIViewController

@property (nonatomic, copy) NSString *adConfigId;
@property (nonatomic, strong) LLAdSize *adSize;

@end

NS_ASSUME_NONNULL_END
