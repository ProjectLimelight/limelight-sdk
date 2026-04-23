//
//  RewardedAdVC.m
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import "RewardedAdVC.h"
@import LimelightSDK;

// MARK: - Private Interface

@interface RewardedAdVC () <LLRewardedAdDelegate>

// MARK: Storyboard UI

@property(weak, nonatomic) IBOutlet UIButton *showAdButton;
@property(weak, nonatomic) IBOutlet UILabel *adUnitIdLabel;
@property(weak, nonatomic) IBOutlet UILabel *adSizeLabel;

// InterstitialAdDelegate
@property(weak, nonatomic) IBOutlet UILabel *onAdLoadedLabel;
@property(weak, nonatomic) IBOutlet UILabel *onAdFailedToLoadLabel;
@property(weak, nonatomic) IBOutlet UILabel *onAdOpenedLabel;
@property(weak, nonatomic) IBOutlet UILabel *onAdImpressionLabel;
@property(weak, nonatomic) IBOutlet UILabel *onAdClickedLabel;
@property(weak, nonatomic) IBOutlet UILabel *onAdClosedLabel;
@property(weak, nonatomic) IBOutlet UILabel *onAdRewardedLabel;

// Controls
@property(weak, nonatomic) IBOutlet UIButton *refreshButton;

- (IBAction)didClickShowAdButton:(id)sender;
- (IBAction)didClickRefreshButton:(id)sender;

// MARK: Ad View

@property (strong, nonatomic) LLRewardedAd *rewardedAd;

@end

// MARK: - Implementation

@implementation RewardedAdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAndLoadAd];
}

- (void)setupAndLoadAd {
    self.adUnitIdLabel.text = self.adConfigId;
    self.adSizeLabel.text = [NSString stringWithFormat:@"%dx%d", (int)self.adSize.width, (int)self.adSize.height];
    
    NSSet<LLAdFormat *> *adFormats = [NSSet setWithObjects:LLAdFormat.banner, LLAdFormat.video, nil];
    
    self.rewardedAd = [[LLRewardedAd alloc] initWithAdUnitId:self.adConfigId];
    self.rewardedAd.delegate = self;
    self.rewardedAd.supportSKOverlay = NO;
    self.rewardedAd.adSize = self.adSize;
    self.rewardedAd.adFormats = adFormats;
    [self.rewardedAd loadAd];
}

- (IBAction)didClickShowAdButton:(id)sender {
    [self showAd];
}

- (void)showAd {
    [self.rewardedAd showFrom:self];
}

- (void)resetEvents {
    self.onAdLoadedLabel.enabled = NO;
    self.onAdFailedToLoadLabel.enabled = NO;
    self.onAdOpenedLabel.enabled = NO;
    self.onAdImpressionLabel.enabled = NO;
    self.onAdClickedLabel.enabled = NO;
    self.onAdClosedLabel.enabled = NO;
    self.onAdRewardedLabel.enabled = NO;
}

- (IBAction)didClickRefreshButton:(id)sender {
    [self refreshAd];
}

- (void)refreshAd {
    [self resetEvents];
    self.refreshButton.enabled = NO;
    [self.rewardedAd loadAd];
}

@end

// MARK: - LimelightRewardedAdDelegate

@implementation RewardedAdVC (LLRewardedAdDelegate)

- (void)onAdLoaded:(LLRewardedAd *)rewardedAd :(LLAd * _Nonnull)ad {
    [self resetEvents];
    self.onAdLoadedLabel.enabled = YES;
    self.showAdButton.enabled = YES;
    self.refreshButton.enabled = YES;
}

- (void)onAdFailedToLoad:(LLRewardedAd *)rewardedAd error:(LLError *)error {
    [self resetEvents];
    self.onAdFailedToLoadLabel.enabled = YES;
    self.refreshButton.enabled = YES;
}

- (void)onAdOpened:(LLRewardedAd *)rewardedAd {
    self.onAdOpenedLabel.enabled = YES;
}

- (void)onAdImpression:(LLRewardedAd *)rewardedAd {
    self.onAdImpressionLabel.enabled = YES;
}

- (void)onAdClicked:(LLRewardedAd *)rewardedAd {
    self.onAdClickedLabel.enabled = YES;
}

- (void)onAdClosed:(LLRewardedAd *)rewardedAd {
    self.onAdClosedLabel.enabled = YES;
}

- (void)onAdRewarded:(LLRewardedAd *)rewardedAd reward:(LLReward *)reward {
    self.onAdRewardedLabel.enabled = YES;
}

@end
