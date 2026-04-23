//
//  MAXInterstitialAdVC.swift
//  DemoSwift
//
// © 2026 Limelight Inc. All Rights Reserved.
//

import AppLovinSDK
import LimelightSDK
import UIKit

// MARK: - MAXInterstitialAdVC
final class MAXInterstitialAdVC: UIViewController {
    
    // MARK: Storyboard UI

    @IBOutlet var showAdButton: UIButton!
    @IBAction func didClickShowAdButton(_ sender: Any) { showAd() }
    // Ad Info
    @IBOutlet var adUnitIdLabel: UILabel!
    @IBOutlet var adSizeLabel: UILabel!
    // MAAdDelegate
    @IBOutlet var didLoadLabel: UILabel!
    @IBOutlet var didFailToLoadAdLabel: UILabel!
    @IBOutlet var didDisplayLabel: UILabel!
    @IBOutlet var didHideLabel: UILabel!
    @IBOutlet var didClickLabel: UILabel!
    @IBOutlet var didFailToDisplayLabel: UILabel!
    // Controls
    @IBOutlet var refreshButton: UIButton!
    @IBAction func didClickRefreshButton(_ sender: Any) { refreshAd() }
    
    // MARK: Ad View
    
    var maInterstitialAd: MAInterstitialAd?

    // Ad View Customizations
    var adConfigId = "1234567890"

    // MARK: UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAndLoadAd()
    }

    // MARK: Actions

    func setupAndLoadAd() {
        adUnitIdLabel.text = adConfigId
        adSizeLabel.text = "-"

        let maInterstitialAd = MAInterstitialAd(adUnitIdentifier: adConfigId)
        maInterstitialAd.delegate = self
        maInterstitialAd.load()

        self.maInterstitialAd = maInterstitialAd
    }

    func showAd() {
        if maInterstitialAd?.isReady == true, maInterstitialAd?.isShowing == false {
            maInterstitialAd?.show()
        }
    }

    func resetEvents() {
        didLoadLabel.isEnabled = false
        didFailToLoadAdLabel.isEnabled = false
        didDisplayLabel.isEnabled = false
        didHideLabel.isEnabled = false
        didClickLabel.isEnabled = false
        didFailToDisplayLabel.isEnabled = false
    }

    func refreshAd() {
        resetEvents()
        refreshButton.isEnabled = false
        maInterstitialAd?.load()
    }
}

// MARK: - MAAdDelegate
extension MAXInterstitialAdVC: MAAdDelegate {
    func didLoad(_ ad: MAAd) {
        adSizeLabel.text = Int(ad.size.width).description + "x" + Int(ad.size.height).description
        didLoadLabel.isEnabled = true
    }

    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        didFailToLoadAdLabel.isEnabled = true
    }

    func didDisplay(_ ad: MAAd) {
        didDisplayLabel.isEnabled = true
    }

    func didHide(_ ad: MAAd) {
        didHideLabel.isEnabled = true
    }

    func didClick(_ ad: MAAd) {
        didClickLabel.isEnabled = true
    }

    func didFail(toDisplay ad: MAAd, withError error: MAError) {
        didFailToDisplayLabel.isEnabled = true
    }
}
