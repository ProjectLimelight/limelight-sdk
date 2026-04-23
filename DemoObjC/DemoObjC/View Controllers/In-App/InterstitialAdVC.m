//
//  InterstitialAdVC.m
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import "InterstitialAdVC.h"
@import LimelightSDK;

// MARK: - Private Interface

@interface InterstitialAdVC ()<LLInterstitialAdDelegate>

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

// Controls
@property(weak, nonatomic) IBOutlet UIButton *refreshButton;

- (IBAction)didClickShowAdButton:(id)sender;
- (IBAction)didClickRefreshButton:(id)sender;

// MARK: Ad View

@property (strong, nonatomic) LLInterstitialAd *interstitialAd;

@end

// MARK: - Implementation

@implementation InterstitialAdVC

// MARK: UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAndLoadAd];
}

// MARK: Actions

- (void)setupAndLoadAd {
    self.adUnitIdLabel.text = self.adConfigId;
    self.adSizeLabel.text = [NSString stringWithFormat:@"%dx%d", (int)self.adSize.width, (int)self.adSize.height];
    
    NSSet<LLAdFormat *> *adFormats = [NSSet setWithObjects:LLAdFormat.banner, LLAdFormat.video, nil];
    
    self.interstitialAd = [[LLInterstitialAd alloc] initWithAdUnitId:self.adConfigId];
    self.interstitialAd.delegate = self;
    self.interstitialAd.supportSKOverlay = NO;
    self.interstitialAd.adSize = self.adSize;
    self.interstitialAd.adFormats = adFormats;
    [self.interstitialAd loadAd];
}

- (IBAction)didClickShowAdButton:(id)sender {
    [self showAd];
}

- (void)showAd {
    [self.interstitialAd showFrom:self];
}

- (void)resetEvents {
    self.onAdLoadedLabel.enabled = NO;
    self.onAdFailedToLoadLabel.enabled = NO;
    self.onAdOpenedLabel.enabled = NO;
    self.onAdImpressionLabel.enabled = NO;
    self.onAdClickedLabel.enabled = NO;
    self.onAdClosedLabel.enabled = NO;
}

- (IBAction)didClickRefreshButton:(id)sender {
    [self refreshAd];
}

- (void)refreshAd {
    [self resetEvents];
    self.refreshButton.enabled = NO;
    [self.interstitialAd loadAd];
}

@end

// MARK: - LimelightInterstitialAdDelegate

@implementation InterstitialAdVC (LLInterstitialAdDelegate)

- (void)onAdLoaded:(LLInterstitialAd *)interstitialAd :(LLAd * _Nonnull)ad {
    [self resetEvents];
    self.onAdLoadedLabel.enabled = YES;
    self.showAdButton.enabled = YES;
    self.refreshButton.enabled = YES;
}

- (void)onAdFailedToLoad:(LLInterstitialAd *)interstitialAd error:(LLError *)error {
    [self resetEvents];
    self.onAdFailedToLoadLabel.enabled = YES;
    self.refreshButton.enabled = YES;
}

- (void)onAdOpened:(LLInterstitialAd *)interstitialAd {
    self.onAdOpenedLabel.enabled = YES;
}

- (void)onAdImpression:(LLInterstitialAd *)interstitialAd {
    self.onAdImpressionLabel.enabled = YES;
}

- (void)onAdClicked:(LLInterstitialAd *)interstitialAd {
    self.onAdClickedLabel.enabled = YES;
}

- (void)onAdClosed:(LLInterstitialAd *)interstitialAd {
    self.onAdClosedLabel.enabled = YES;
}

@end
