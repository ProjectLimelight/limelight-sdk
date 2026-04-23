//
//  InterstitialAdVC.swift
//  DemoSwift
//
// © 2026 Limelight Inc. All Rights Reserved.
//

import UIKit
import LimelightSDK

final class InterstitialAdVC: UIViewController {
    
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
    // Controls
    @IBOutlet var refreshButton: UIButton!
    @IBAction func didClickRefreshButton(_ sender: Any) { refreshAd() }

    // MARK: Ad View
    
    var interstitialAd: LimelightInterstitialAd?

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
        
        interstitialAd = LimelightInterstitialAd(adUnitId: adConfigId)
        interstitialAd?.delegate = self
        interstitialAd?.supportSKOverlay = supportSKOverlay
        interstitialAd?.adSize = adSize
        interstitialAd?.adFormats = adFormats
        interstitialAd?.loadAd()
    }
    
    func showAd() {
        interstitialAd?.show(from: self)
    }
    
    func resetEvents() {
        onAdLoadedLabel.isEnabled = false
        onAdFailedToLoadLabel.isEnabled = false
        onAdOpenedLabel.isEnabled = false
        onAdImpressionLabel.isEnabled = false
        onAdClickedLabel.isEnabled = false
        onAdClosedLabel.isEnabled = false
    }
    
    func refreshAd() {
        resetEvents()
        refreshButton.isEnabled = false
        interstitialAd?.loadAd()
    }
}

extension InterstitialAdVC: LimelightInterstitialAdDelegate {
    func onAdLoaded(interstitialAd: LimelightInterstitialAd, ad: LimelightAd) {
        resetEvents()
        onAdLoadedLabel.isEnabled = true
        showAdButton.isEnabled = true
        refreshButton.isEnabled = true
    }

    func onAdFailedToLoad(interstitialAd: LimelightInterstitialAd, error: LimelightError?) {
        resetEvents()
        onAdFailedToLoadLabel.isEnabled = true
        refreshButton.isEnabled = true
    }

    func onAdOpened(interstitialAd: LimelightInterstitialAd) {
        onAdOpenedLabel.isEnabled = true
    }

    func onAdImpression(interstitialAd: LimelightInterstitialAd) {
        onAdImpressionLabel.isEnabled = true
    }

    func onAdClicked(interstitialAd: LimelightInterstitialAd) {
        onAdClickedLabel.isEnabled = true
    }

    func onAdClosed(interstitialAd: LimelightInterstitialAd) {
        onAdClosedLabel.isEnabled = true
    }
}
