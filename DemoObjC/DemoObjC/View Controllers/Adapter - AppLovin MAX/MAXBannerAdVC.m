//
//  MAXBannerAdVC.m
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import "MAXBannerAdVC.h"
#import <AppLovinSDK/AppLovinSDK.h>
#import <LimelightSDK/LimelightSDK.h>
#import <LimelightSDKAppLovinAdapter/LimelightSDKAppLovinAdapter.h>

// MARK: - Private Interface

@interface MAXBannerAdVC ()

// MARK: Storyboard UI

@property (nonatomic, weak) IBOutlet UIView *adContainerView;
// Ad Info
@property (nonatomic, weak) IBOutlet UILabel *adUnitIdLabel;
@property (nonatomic, weak) IBOutlet UILabel *adSizeLabel;
// MAAdViewAdDelegate
@property (nonatomic, weak) IBOutlet UILabel *didLoadLabel;
@property (nonatomic, weak) IBOutlet UILabel *didFailToLoadAdLabel;
@property (nonatomic, weak) IBOutlet UILabel *didDisplayLabel;
@property (nonatomic, weak) IBOutlet UILabel *didHideLabel;
@property (nonatomic, weak) IBOutlet UILabel *didClickLabel;
@property (nonatomic, weak) IBOutlet UILabel *didFailToDisplayLabel;
@property (nonatomic, weak) IBOutlet UILabel *didExpandLabel;
@property (nonatomic, weak) IBOutlet UILabel *didCollapseLabel;
// Controls
@property (nonatomic, weak) IBOutlet UIButton *refreshButton;
@property (nonatomic, weak) IBOutlet UIButton *stopAutoRefreshButton;

- (IBAction)didClickRefreshButton:(id)sender;
- (IBAction)didClickStopAutoRefreshButton:(id)sender;

// MARK: Ad View

@property (nonatomic, strong, nullable) MAAdView *maAdView;

@end

// MARK: - Implementation

@implementation MAXBannerAdVC

// MARK: UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAndLoadAd];
}

// MARK: Actions

- (IBAction)didClickRefreshButton:(id)sender {
    [self refreshAd];
}

- (IBAction)didClickStopAutoRefreshButton:(id)sender {
    [self stopAutoRefresh];
}

- (void)setupAndLoadAd {
    self.adUnitIdLabel.text = self.adConfigId;
    self.adSizeLabel.text = [NSString stringWithFormat:@"%dx%d", (int)self.adSize.width, (int)self.adSize.height];
    
    MAAdView *maAdView = [[MAAdView alloc] initWithAdUnitIdentifier:self.adConfigId
                                                           adFormat:self.adFormat
                                                      configuration:nil];
    maAdView.delegate = self;
    maAdView.frame = CGRectMake(0, 0, self.adSize.width, self.adSize.height);
    
    if (self.isAutoRefreshEnabled) {
        [maAdView startAutoRefresh];
    } else {
        // Set this extra parameter to work around SDK bug that ignores calls to stopAutoRefresh()
        [maAdView setExtraParameterForKey:@"allow_pause_auto_refresh_immediately" value:@"true"];
        [maAdView stopAutoRefresh];
    }
    
    if (self.isAdaptive) {
        [maAdView setExtraParameterForKey:@"adaptive_banner" value:@"true"];
    }
    
    // Add as a subview
    maAdView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.adContainerView addSubview:maAdView];
    
    NSLayoutConstraint *widthConstraint = [self.adContainerView.widthAnchor constraintEqualToAnchor:maAdView.widthAnchor multiplier:1];
    NSLayoutConstraint *heightConstraint = [self.adContainerView.heightAnchor constraintEqualToAnchor:maAdView.heightAnchor multiplier:1];
    [self.adContainerView addConstraints:@[widthConstraint, heightConstraint]];
    
    self.maAdView = maAdView;
    [maAdView loadAd];
}

- (void)resetEvents {
    self.didLoadLabel.enabled = NO;
    self.didFailToLoadAdLabel.enabled = NO;
    self.didDisplayLabel.enabled = NO;
    self.didHideLabel.enabled = NO;
    self.didClickLabel.enabled = NO;
    self.didFailToDisplayLabel.enabled = NO;
    self.didExpandLabel.enabled = NO;
    self.didCollapseLabel.enabled = NO;
}

- (void)refreshAd {
    [self resetEvents];
    self.refreshButton.enabled = NO;
    [self.maAdView loadAd];
}

- (void)stopAutoRefresh {
    self.stopAutoRefreshButton.enabled = NO;
    [self.maAdView stopAutoRefresh];
}

// MARK: MAAdViewAdDelegate

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

- (void)didExpandAd:(MAAd *)ad {
    self.didExpandLabel.enabled = YES;
}

- (void)didCollapseAd:(MAAd *)ad {
    self.didCollapseLabel.enabled = YES;
}

@end
