//
//  MAXBannerAdVC.swift
//  DemoSwift
//
// © 2026 Limelight Inc. All Rights Reserved.
//

import AppLovinSDK
import LimelightSDK
import LimelightSDKAppLovinAdapter
import UIKit

// MARK: - MAXBannerAdVC
final class MAXBannerAdVC: UIViewController {
    
    // MARK: Storyboard UI

    @IBOutlet var adContainerView: UIView!
    // Ad Info
    @IBOutlet var adUnitIdLabel: UILabel!
    @IBOutlet var adSizeLabel: UILabel!
    // MAAdViewAdDelegate
    @IBOutlet var didLoadLabel: UILabel!
    @IBOutlet var didFailToLoadAdLabel: UILabel!
    @IBOutlet var didDisplayLabel: UILabel!
    @IBOutlet var didHideLabel: UILabel!
    @IBOutlet var didClickLabel: UILabel!
    @IBOutlet var didFailToDisplayLabel: UILabel!
    @IBOutlet var didExpandLabel: UILabel!
    @IBOutlet var didCollapseLabel: UILabel!
    // Controls
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var stopAutoRefreshButton: UIButton!
    @IBAction func didClickRefreshButton(_ sender: Any) { refreshAd() }

    @IBAction func didClickStopAutoRefreshButton(_ sender: Any) { stopAutoRefresh() }

    // MARK: Ad View

    var maAdView: MAAdView?

    // Ad View Customizations
    var adConfigId = "1234567890"
    var adSize: CGSize = .zero
    var adFormat: MAAdFormat = .banner
    var isAutoRefreshEnabled: Bool = true
    var isAdaptive: Bool = false

    // MARK: UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAndLoadAd()
    }
    
    // MARK: Actions
    
    func setupAndLoadAd() {
        adUnitIdLabel.text = adConfigId
        adSizeLabel.text = Int(adSize.width).description + "x" + Int(adSize.height).description

        let maAdView = MAAdView(adUnitIdentifier: adConfigId, adFormat: adFormat, configuration: nil)
        maAdView.delegate = self
        maAdView.frame = CGRect(origin: .zero, size: adSize)

        if isAutoRefreshEnabled {
            maAdView.startAutoRefresh()
        } else {
            // Set this extra parameter to work around SDK bug that ignores calls to stopAutoRefresh()
            maAdView.setExtraParameterForKey("allow_pause_auto_refresh_immediately", value: "true")
            maAdView.stopAutoRefresh()
        }

        if isAdaptive {
            maAdView.setExtraParameterForKey("adaptive_banner", value: "true")
        }

        // Add as a subview
        maAdView.translatesAutoresizingMaskIntoConstraints = false
        adContainerView.addSubview(maAdView)
        let widthConstraint = adContainerView.widthAnchor.constraint(equalTo: maAdView.widthAnchor, multiplier: 1)
        let heightConstraint = adContainerView.heightAnchor.constraint(equalTo: maAdView.heightAnchor, multiplier: 1)
        adContainerView.addConstraints([widthConstraint, heightConstraint])

        self.maAdView = maAdView

        maAdView.loadAd()
    }
    
    func resetEvents() {
        didLoadLabel.isEnabled = false
        didFailToLoadAdLabel.isEnabled = false
        didDisplayLabel.isEnabled = false
        didHideLabel.isEnabled = false
        didClickLabel.isEnabled = false
        didFailToDisplayLabel.isEnabled = false
        didExpandLabel.isEnabled = false
        didCollapseLabel.isEnabled = false
    }
    
    func refreshAd() {
        resetEvents()
        refreshButton.isEnabled = false
        maAdView?.loadAd()
    }
    
    func stopAutoRefresh() {
        stopAutoRefreshButton.isEnabled = false
        maAdView?.stopAutoRefresh()
    }
}

// MARK: - MAAdViewAdDelegate
extension MAXBannerAdVC: MAAdViewAdDelegate {
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

    func didExpand(_ ad: MAAd) {
        didExpandLabel.isEnabled = true
    }

    func didCollapse(_ ad: MAAd) {
        didCollapseLabel.isEnabled = true
    }
}
