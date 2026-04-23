//
//  AppDelegate.m
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import "AppDelegate.h"
@import LimelightSDK;

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    
    Limelight.logLevel = LLLogLevel.info;
    [Limelight initializeWithHost:@"https://ads-forty-flsk9l.ortb.net/openrtb/526274869" completion:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Limelight initialization failed: %@", error);
        } else {
            NSLog(@"Limelight successfully initialized");
        }
    }];
    
    return YES;
}

@end
