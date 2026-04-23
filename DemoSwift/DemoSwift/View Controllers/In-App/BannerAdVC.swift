//
//  BannerAdVC.swift
//  DemoSwift
//
// © 2026 Limelight Inc. All Rights Reserved.
//

import LimelightSDK
import UIKit

// MARK: - BannerAdVC
final class BannerAdVC: UIViewController {
    
    // MARK: Storyboard UI
    
    @IBOutlet var adContainerView: UIView!
    // Ad Info
    @IBOutlet var adUnitIdLabel: UILabel!
    @IBOutlet var adSizeLabel: UILabel!
    // AdViewDelegate
    @IBOutlet var onAdLoadedLabel: UILabel!
    @IBOutlet var onAdFailedToLoadLabel: UILabel!
    @IBOutlet var onAdOpenedLabel: UILabel!
    @IBOutlet var onAdImpressionLabel: UILabel!
    @IBOutlet var onAdClickedLabel: UILabel!
    @IBOutlet var onAdClosedLabel: UILabel!
    // AdViewVideoPlaybackDelegate
    @IBOutlet var onVideoPlaybackDidPauseLabel: UILabel!
    @IBOutlet var onVideoPlaybackDidResumeLabel: UILabel!
    @IBOutlet var onVideoPlaybackWasMutedLabel: UILabel!
    @IBOutlet var onVideoPlaybackWasUnmutedLabel: UILabel!
    @IBOutlet var onVideoPlaybackDidCompleteLabel: UILabel!
    // Controls
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var stopAutoRefreshButton: UIButton!
    @IBAction func didClickRefreshButton(_ sender: Any) { refreshAd() }
    @IBAction func didClickStopAutoRefreshButton(_ sender: Any) { stopAutoRefresh() }
    @IBOutlet var customTargetingSwitch: UISwitch!
    @IBAction func customTargetingSwitchValueChanged(_ sender: Any) { applyCustomTargeting(customTargetingSwitch.isOn) }
    
    // MARK: Ad View
    
    var bannerAdView: LimelightAdView?
    
    // Ad View Customizations
    var adConfigId = "1234567890"
    var adSize: LimelightAdSize = .banner_320x50
    var adFormats: Set<LimelightAdFormat> = [.banner]
    var adRefreshInterval: TimeInterval = 0
    
    // MARK: UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAndLoadAd()
    }
    
    func setupAndLoadAd() {
        adUnitIdLabel.text = adConfigId
        adSizeLabel.text = Int(adSize.width).description + "x" + Int(adSize.height).description
        
        let bannerAdView = LimelightAdView(adUnitId: adConfigId, adSize: adSize)
        bannerAdView.delegate = self
        bannerAdView.videoPlaybackDelegate = self
        bannerAdView.adFormats = adFormats
        
        if adRefreshInterval > 0 {
            bannerAdView.autoRefreshInterval = adRefreshInterval
        }
        
        // Add as a subview
        bannerAdView.translatesAutoresizingMaskIntoConstraints = false
        adContainerView.addSubview(bannerAdView)
        let widthConstraint = adContainerView.widthAnchor.constraint(equalTo: bannerAdView.widthAnchor, multiplier: 1)
        let heightConstraint = adContainerView.heightAnchor.constraint(equalTo: bannerAdView.heightAnchor, multiplier: 1)
        adContainerView.addConstraints([widthConstraint, heightConstraint])
        
        self.bannerAdView = bannerAdView
        
        bannerAdView.loadAd()
    }
    
    func resetEvents() {
        onAdLoadedLabel.isEnabled = false
        onAdFailedToLoadLabel.isEnabled = false
        onAdOpenedLabel.isEnabled = false
        onAdImpressionLabel.isEnabled = false
        onAdClickedLabel.isEnabled = false
        onAdClosedLabel.isEnabled = false
        
        onVideoPlaybackDidPauseLabel.isEnabled = false
        onVideoPlaybackDidResumeLabel.isEnabled = false
        onVideoPlaybackWasMutedLabel.isEnabled = false
        onVideoPlaybackWasUnmutedLabel.isEnabled = false
        onVideoPlaybackDidCompleteLabel.isEnabled = false
    }
    
    func refreshAd() {
        resetEvents()
        refreshButton.isEnabled = false
        stopAutoRefreshButton.isEnabled = true
        bannerAdView?.loadAd()
    }
    
    func stopAutoRefresh() {
        stopAutoRefreshButton.isEnabled = false
        bannerAdView?.stopRefresh()
    }
    
    func applyCustomTargeting(_ shouldApply: Bool) {
        Limelight.targeting = shouldApply ? LimelightTargeting.demo() : nil
    }
}

// MARK: - LimelightAdViewDelegate
extension BannerAdVC: LimelightAdViewDelegate {
    func onAdLoaded(adView: LimelightAdView, ad: LimelightAd) {
        resetEvents()
        onAdLoadedLabel.isEnabled = true
        refreshButton.isEnabled = true
        
        adContainerView.constraints.first { $0.firstAttribute == .width }?.constant = CGFloat(adSize.width)
        adContainerView.constraints.first { $0.firstAttribute == .height }?.constant = CGFloat(adSize.height)
    }
    
    func onAdFailedToLoad(adView: LimelightAdView, error: LimelightError?) {
        resetEvents()
        onAdFailedToLoadLabel.isEnabled = true
        refreshButton.isEnabled = true
    }
    
    func onAdOpened(adView: LimelightAdView) {
        onAdOpenedLabel.isEnabled = true
    }
    
    func onAdImpression(adView: LimelightAdView) {
        onAdImpressionLabel.isEnabled = true
    }

    func onAdClicked(adView: LimelightAdView) {
        onAdClickedLabel.isEnabled = true
    }

    func onAdClosed(adView: LimelightAdView) {
        onAdClosedLabel.isEnabled = true
    }
}

// MARK: - LimelightAdViewVideoPlaybackDelegate
extension BannerAdVC: LimelightAdViewVideoPlaybackDelegate {
    func onVideoPlaybackDidPause(adView: LimelightSDK.LimelightAdView) {
        onVideoPlaybackDidPauseLabel.isEnabled = true
    }

    func onVideoPlaybackDidResume(adView: LimelightSDK.LimelightAdView) {
        onVideoPlaybackDidResumeLabel.isEnabled = true
    }

    func onVideoPlaybackWasMuted(adView: LimelightSDK.LimelightAdView) {
        onVideoPlaybackWasMutedLabel.isEnabled = true
    }

    func onVideoPlaybackWasUnmuted(adView: LimelightSDK.LimelightAdView) {
        onVideoPlaybackWasUnmutedLabel.isEnabled = true
    }

    func onVideoPlaybackDidComplete(adView: LimelightSDK.LimelightAdView) {
        onVideoPlaybackDidCompleteLabel.isEnabled = true
    }
}
