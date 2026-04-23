//
//  MAXRewardedAdVC.swift
//  DemoSwift
//
// © 2026 Limelight Inc. All Rights Reserved.
//

import AppLovinSDK
import LimelightSDK
import UIKit

// MARK: - MAXRewardedAdVC
final class MAXRewardedAdVC: UIViewController {
    
    // MARK: Storyboard UI

    @IBOutlet var showAdButton: UIButton!
    @IBAction func didClickShowAdButton(_ sender: Any) {showAd() }

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
    @IBOutlet var didRewardUserLabel: UILabel!
    // Controls
    @IBOutlet var refreshButton: UIButton!
    @IBAction func didClickRefreshButton(_ sender: Any) { refreshAd() }

    // MARK: Ad View

    var maRewardedAd: MARewardedAd?

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

        let maRewardedAd = MARewardedAd.shared(withAdUnitIdentifier: adConfigId)
        maRewardedAd.delegate = self
        maRewardedAd.load()

        self.maRewardedAd = maRewardedAd
    }

    func showAd() {
        if maRewardedAd?.isReady == true, maRewardedAd?.isShowing == false {
            maRewardedAd?.show()
        }
    }

    func resetEvents() {
        didLoadLabel.isEnabled = false
        didFailToLoadAdLabel.isEnabled = false
        didDisplayLabel.isEnabled = false
        didHideLabel.isEnabled = false
        didClickLabel.isEnabled = false
        didFailToDisplayLabel.isEnabled = false
        didRewardUserLabel.isEnabled = false
    }

    func refreshAd() {
        resetEvents()
        refreshButton.isEnabled = false
        maRewardedAd?.load()
    }
}

// MARK: - MARewardedAdDelegate
extension MAXRewardedAdVC: MARewardedAdDelegate {
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

    func didRewardUser(for ad: MAAd, with reward: MAReward) {
        didRewardUserLabel.isEnabled = true
    }
}
