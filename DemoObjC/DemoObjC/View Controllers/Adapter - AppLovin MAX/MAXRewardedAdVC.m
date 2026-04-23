//
//  MAXRewardedAdVC.m
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import "MAXRewardedAdVC.h"
#import <AppLovinSDK/AppLovinSDK.h>
#import <LimelightSDK/LimelightSDK.h>

// MARK: - Private Interface

@interface MAXRewardedAdVC ()

// MARK: Storyboard UI

@property (nonatomic, weak) IBOutlet UIButton *showAdButton;
// Ad Info
@property (nonatomic, weak) IBOutlet UILabel *adUnitIdLabel;
@property (nonatomic, weak) IBOutlet UILabel *adSizeLabel;
// MAAdDelegate
@property (nonatomic, weak) IBOutlet UILabel *didLoadLabel;
@property (nonatomic, weak) IBOutlet UILabel *didFailToLoadAdLabel;
@property (nonatomic, weak) IBOutlet UILabel *didDisplayLabel;
@property (nonatomic, weak) IBOutlet UILabel *didHideLabel;
@property (nonatomic, weak) IBOutlet UILabel *didClickLabel;
@property (nonatomic, weak) IBOutlet UILabel *didFailToDisplayLabel;
@property (nonatomic, weak) IBOutlet UILabel *didRewardUserLabel;
// Controls
@property (nonatomic, weak) IBOutlet UIButton *refreshButton;

- (IBAction)didClickShowAdButton:(id)sender;
- (IBAction)didClickRefreshButton:(id)sender;

// MARK: Ad View

@property (nonatomic, strong, nullable) MARewardedAd *maRewardedAd;

@end

// MARK: - Implementation

@implementation MAXRewardedAdVC

// MARK: UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAndLoadAd];
}

// MARK: Actions

- (IBAction)didClickShowAdButton:(id)sender {
    [self showAd];
}

- (IBAction)didClickRefreshButton:(id)sender {
    [self refreshAd];
}

- (void)setupAndLoadAd {
    self.adUnitIdLabel.text = self.adConfigId;
    self.adSizeLabel.text = @"-";
    
    MARewardedAd *maRewardedAd = [MARewardedAd sharedWithAdUnitIdentifier:self.adConfigId];
    maRewardedAd.delegate = self;
    [maRewardedAd loadAd];
    self.maRewardedAd = maRewardedAd;
}

- (void)showAd {
    if (self.maRewardedAd.isReady && !self.maRewardedAd.isShowing) {
        [self.maRewardedAd showAd];
    }
}

- (void)resetEvents {
    self.didLoadLabel.enabled = NO;
    self.didFailToLoadAdLabel.enabled = NO;
    self.didDisplayLabel.enabled = NO;
    self.didHideLabel.enabled = NO;
    self.didClickLabel.enabled = NO;
    self.didFailToDisplayLabel.enabled = NO;
    self.didRewardUserLabel.enabled = NO;
}

- (void)refreshAd {
    [self resetEvents];
    self.refreshButton.enabled = NO;
    [self.maRewardedAd loadAd];
}

// MARK: MARewardedAdDelegate

- (void)didLoadAd:(MAAd *)ad {
    self.adSizeLabel.text = [NSString stringWithFormat:@"%dx%d", (int)ad.size.width, (int)ad.size.height];
    self.didLoadLabel.enabled = YES;
}

- (void)didFailToLoadAdForAdUnitIdentifier:(NSString *)adUnitIdentifier withError:(MAError *)error {
    self.didFailToLoadAdLabel.enabled = YES;
}

- (void)didDisplayAd:(MAAd *)ad {
    self.didDisplayLabel.enabled = YES;
}

- (void)didHideAd:(MAAd *)ad {
    self.didHideLabel.enabled = YES;
}

- (void)didClickAd:(MAAd *)ad {
    self.didClickLabel.enabled = YES;
}

- (void)didFailToDisplayAd:(MAAd *)ad withError:(MAError *)error {
    self.didFailToDisplayLabel.enabled = YES;
}

- (void)didRewardUserForAd:(MAAd *)ad withReward:(MAReward *)reward {
    self.didRewardUserLabel.enabled = YES;
}

@end
