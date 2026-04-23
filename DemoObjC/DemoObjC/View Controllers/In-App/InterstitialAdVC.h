//
//  InterstitialAdVC.h
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InterstitialAdVC : UIViewController

@property (nonatomic, copy) NSString *adConfigId;
@property (nonatomic, assign) CGSize adSize;
@property (nonatomic, strong) NSArray *adFormats;

@end

NS_ASSUME_NONNULL_END
