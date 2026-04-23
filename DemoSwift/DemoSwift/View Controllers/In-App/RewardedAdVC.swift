//
//  RewardedAdVC.swift
//  DemoSwift
//
// © 2026 Limelight Inc. All Rights Reserved.
//

import UIKit
import LimelightSDK

// MARK: - RewardedAdVC
final class RewardedAdVC: UIViewController {
    
    // MARK: Storyboard UI
    
    @IBOutlet var showAdButton: UIButton!
    @IBAction func didClickShowAdButton(_ sender: Any) { showAd() }
    // Ad Info
    @IBOutlet var adUnitIdLabel: UILabel!
    @IBOutlet var adSizeLabel: UILabel!
    // InterstitialAdDelegate
    @IBOutlet var onAdLoadedLabel: UILabel!
    @IBOutlet var onAdFailedToLoadLabel: UILabel!
    @IBOutlet var onAdOpenedLabel: UILabel!
    @IBOutlet var onAdImpressionLabel: UILabel!
    @IBOutlet var onAdClickedLabel: UILabel!
    @IBOutlet var onAdClosedLabel: UILabel!
    @IBOutlet var onAdRewardedLabel: UILabel!
    // Controls
    @IBOutlet var refreshButton: UIButton!
    @IBAction func didClickRefreshButton(_ sender: Any) { refreshAd() }

    // MARK: Ad View
    
    var rewardedAd: LimelightRewardedAd?
    
    // Ad View Customizations
    var adConfigId = "1234567890"
    var adSize: CGSize = .init(width: 480, height: 320)
    var adFormats: Set<LimelightAdFormat> = [.banner, .video]
    // SKAdNetwork
    var supportSKOverlay = false
    
    // MARK: UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAndLoadAd()
    }
    
    func setupAndLoadAd() {
        adUnitIdLabel.text = adConfigId
        adSizeLabel.text = Int(adSize.width).description + "x" + Int(adSize.height).description
        
        rewardedAd = LimelightRewardedAd(adUnitId: adConfigId)
        rewardedAd?.delegate = self
        rewardedAd?.supportSKOverlay = supportSKOverlay
        rewardedAd?.adSize = adSize
        rewardedAd?.adFormats = adFormats
        rewardedAd?.loadAd()
    }
    
    func showAd() {
        rewardedAd?.show(from: self)
    }
    
    func resetEvents() {
        onAdLoadedLabel.isEnabled = false
        onAdFailedToLoadLabel.isEnabled = false
        onAdOpenedLabel.isEnabled = false
        onAdImpressionLabel.isEnabled = false
        onAdClickedLabel.isEnabled = false
        onAdClosedLabel.isEnabled = false
        onAdRewardedLabel.isEnabled = false
    }
    
    func refreshAd() {
        resetEvents()
        refreshButton.isEnabled = false
        rewardedAd?.loadAd()
    }
}

// MARK: - LimelightRewardedAdDelegate
extension RewardedAdVC: LimelightRewardedAdDelegate {
    func onAdLoaded(rewardedAd: LimelightRewardedAd, ad: LimelightAd) {
        resetEvents()
        onAdLoadedLabel.isEnabled = true
        showAdButton.isEnabled = true
        refreshButton.isEnabled = true
    }
    
    func onAdFailedToLoad(rewardedAd: LimelightRewardedAd, error: LimelightError?) {
        resetEvents()
        onAdFailedToLoadLabel.isEnabled = true
        refreshButton.isEnabled = true
    }
    
    func onAdOpened(rewardedAd: LimelightRewardedAd) {
        onAdOpenedLabel.isEnabled = true
    }
    
    func onAdImpression(rewardedAd: LimelightRewardedAd) {
        onAdImpressionLabel.isEnabled = true
    }
    
    func onAdClicked(rewardedAd: LimelightRewardedAd) {
        onAdClickedLabel.isEnabled = true
    }
    
    func onAdClosed(rewardedAd: LimelightRewardedAd) {
        onAdClosedLabel.isEnabled = true
    }
    
    func onAdRewarded(rewardedAd: LimelightRewardedAd, reward: LimelightReward) {
        onAdRewardedLabel.isEnabled = true
    }
}
