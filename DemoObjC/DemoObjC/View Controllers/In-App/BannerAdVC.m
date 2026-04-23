//
//  BannerAdVC.m
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import "BannerAdVC.h"
#import "Targeting.h"
@import LimelightSDK;

// MARK: - Private Interface

@interface BannerAdVC () <LLAdViewDelegate, LLAdViewVideoPlaybackDelegate>

// MARK: Storyboard UI

@property (weak, nonatomic) IBOutlet UIView *adContainerView;
@property (weak, nonatomic) IBOutlet UILabel *adUnitIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *adSizeLabel;

// AdViewDelegate
@property (weak, nonatomic) IBOutlet UILabel *onAdLoadedLabel;
@property (weak, nonatomic) IBOutlet UILabel *onAdFailedToLoadLabel;
@property (weak, nonatomic) IBOutlet UILabel *onAdOpenedLabel;
@property (weak, nonatomic) IBOutlet UILabel *onAdImpressionLabel;
@property (weak, nonatomic) IBOutlet UILabel *onAdClickedLabel;
@property (weak, nonatomic) IBOutlet UILabel *onAdClosedLabel;

// AdViewVideoPlaybackDelegate
@property (weak, nonatomic) IBOutlet UILabel *onVideoPlaybackDidPauseLabel;
@property (weak, nonatomic) IBOutlet UILabel *onVideoPlaybackDidResumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *onVideoPlaybackWasMutedLabel;
@property (weak, nonatomic) IBOutlet UILabel *onVideoPlaybackWasUnmutedLabel;
@property (weak, nonatomic) IBOutlet UILabel *onVideoPlaybackDidCompleteLabel;

// Controls
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *stopAutoRefreshButton;
@property (weak, nonatomic) IBOutlet UISwitch *customTargetingSwitch;

- (IBAction)didClickRefreshButton:(id)sender;
- (IBAction)didClickStopAutoRefreshButton:(id)sender;
- (IBAction)customTargetingSwitchValueChanged:(id)sender;

// MARK: Ad View

@property (strong, nonatomic) LLAdView *bannerAdView;

@end

// MARK: - Implementation

@implementation BannerAdVC

// MARK: UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAndLoadAd];
}

// MARK: Actions

- (void)setupAndLoadAd {
    self.adUnitIdLabel.text = self.adConfigId;
    self.adSizeLabel.text = [NSString stringWithFormat:@"%dx%d", (int)self.adSize.width, (int)self.adSize.height];
    
    NSSet<LLAdFormat *> *adFormats = [NSSet setWithObjects: LLAdFormat.banner, nil];
    
    LLAdView *bannerAdView = [[LLAdView alloc] initWithAdUnitId:self.adConfigId adSize:self.adSize];
    bannerAdView.delegate = self;
    bannerAdView.videoPlaybackDelegate = self;
    bannerAdView.adFormats = adFormats;
    
    // Add as a subview
    bannerAdView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.adContainerView addSubview:bannerAdView];
    
    NSArray *constraints = @[
        [NSLayoutConstraint constraintWithItem:bannerAdView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.adContainerView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:bannerAdView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.adContainerView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]
    ];
    [self.adContainerView addConstraints:constraints];
    
    self.bannerAdView = bannerAdView;
    
    [bannerAdView loadAd];
}

- (void)resetEvents {
    self.onAdLoadedLabel.enabled = NO;
    self.onAdFailedToLoadLabel.enabled = NO;
    self.onAdOpenedLabel.enabled = NO;
    self.onAdImpressionLabel.enabled = NO;
    self.onAdClickedLabel.enabled = NO;
    self.onAdClosedLabel.enabled = NO;
    
    self.onVideoPlaybackDidPauseLabel.enabled = NO;
    self.onVideoPlaybackDidResumeLabel.enabled = NO;
    self.onVideoPlaybackWasMutedLabel.enabled = NO;
    self.onVideoPlaybackWasUnmutedLabel.enabled = NO;
    self.onVideoPlaybackDidCompleteLabel.enabled = NO;
}

- (IBAction)didClickRefreshButton:(id)sender {
    [self refreshAd];
}

- (void)refreshAd {
    [self resetEvents];
    self.refreshButton.enabled = NO;
    self.stopAutoRefreshButton.enabled = YES;
    [self.bannerAdView loadAd];
}

- (IBAction)customTargetingSwitchValueChanged:(id)sender {
    Limelight.targeting = self.customTargetingSwitch.isOn ? LLTargeting.demo : nil;
}

- (IBAction)didClickStopAutoRefreshButton:(id)sender {
    [self stopAutoRefresh];
}

- (void)stopAutoRefresh {
    self.stopAutoRefreshButton.enabled = NO;
    [self.bannerAdView stopRefresh];
}

@end

// MARK: - LimelightAdViewDelegate
@implementation BannerAdVC (LLAdViewDelegate)

- (void)onAdLoaded:(LLAdView *)adView :(LLAd * _Nonnull)ad {
    [self resetEvents];
    self.onAdLoadedLabel.enabled = YES;
    self.refreshButton.enabled = YES;
    
    CGSize size =  self.adSize.cgSize;
    NSArray *constraints = self.adContainerView.constraints;
    NSLayoutConstraint *widthConstraint = [constraints filteredArrayUsingPredicate:
        [NSPredicate predicateWithBlock:^BOOL(NSLayoutConstraint *c, NSDictionary *_) {
            return c.firstAttribute == NSLayoutAttributeWidth;
        }]
    ].firstObject;
    NSLayoutConstraint *heightConstraint = [constraints filteredArrayUsingPredicate:
        [NSPredicate predicateWithBlock:^BOOL(NSLayoutConstraint *c, NSDictionary *_) {
            return c.firstAttribute == NSLayoutAttributeHeight;
        }]
    ].firstObject;
    widthConstraint.constant = size.width;
    heightConstraint.constant = size.height;
}

- (void)onAdFailedToLoad:(LLAdView *)adView error:(LLError *)error {
    [self resetEvents];
    self.onAdFailedToLoadLabel.enabled = YES;
    self.refreshButton.enabled = YES;
}

- (void)onAdOpened:(LLAdView *)adView {
    self.onAdOpenedLabel.enabled = YES;
}

- (void)onAdImpression:(LLAdView *)adView {
    self.onAdImpressionLabel.enabled = YES;
}

- (void)onAdClicked:(LLAdView *)adView {
    self.onAdClickedLabel.enabled = YES;
}

- (void)onAdClosed:(LLAdView *)adView {
    self.onAdClosedLabel.enabled = YES;
}

@end

// MARK: - LimelightAdViewVideoPlaybackDelegate
@implementation BannerAdVC (LLAdViewVideoPlaybackDelegate)

- (void)onVideoPlaybackDidPause:(LLAdView *)adView {
    self.onVideoPlaybackDidPauseLabel.enabled = YES;
}

- (void)onVideoPlaybackDidResume:(LLAdView *)adView {
    self.onVideoPlaybackDidResumeLabel.enabled = YES;
}

- (void)onVideoPlaybackWasMuted:(LLAdView *)adView {
    self.onVideoPlaybackWasMutedLabel.enabled = YES;
}

- (void)onVideoPlaybackWasUnmuted:(LLAdView *)adView {
    self.onVideoPlaybackWasUnmutedLabel.enabled = YES;
}

- (void)onVideoPlaybackDidComplete:(LLAdView *)adView {
    self.onVideoPlaybackDidCompleteLabel.enabled = YES;
}

@end
