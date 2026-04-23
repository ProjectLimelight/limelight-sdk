//
//  TestCase.swift
//  DemoSwift
//
// © 2026 Limelight Inc. All Rights Reserved.
//

import LimelightSDK
import UIKit

// MARK: - TestCase

struct TestCase {
    let title: String
    let storyboardId: String
    let configurationClosure: ((_ vc: UIViewController) -> Void)?

    func makeViewController() -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: storyboardId)
        vc.title = title
        configurationClosure?(vc)
        return vc
    }
}

extension TestCase {
    static let testCases: [String: [TestCase]] = [
        "In-App": allInAppCases,
        "AppLovin MAX": allAppLovinCases,
    ]

    static func index(ofSection: String) -> Int? {
        let keys = testCases.keys.map({ String($0) })
        return keys.firstIndex(of: ofSection)
    }

    static func sectionKey(ofIndex: Int) -> String? {
        let keys = testCases.keys.map({ String($0) })
        return keys.count > ofIndex ? keys[ofIndex] : nil
    }
}

// MARK: - In-App

extension TestCase {
    private static let allInAppCases: [TestCase] = banners + interstitials + rewarded

    // MARK: Banners
    private static let banners: [TestCase] = [
        TestCase(
            title: "Banner [320x50]",
            storyboardId: "BannerAdVC",
            configurationClosure: { vc in
                let bannerController = vc as! BannerAdVC
                bannerController.adSize = .banner_320x50
                bannerController.adConfigId = "123456789"
            }
        ),
        TestCase(
            title: "Banner [300x250]",
            storyboardId: "BannerAdVC",
            configurationClosure: { vc in
                let bannerController = vc as! BannerAdVC
                bannerController.adSize = .banner_300x250
                bannerController.adConfigId = "123456789"
            }
        ),
    ]

    // MARK: Interstitials
    private static let interstitials: [TestCase] = [
        TestCase(
            title: "Interstitial [Banner] [320x480]",
            storyboardId: "InterstitialAdVC",
            configurationClosure: { vc in
                let interstitialController = vc as! InterstitialAdVC
                interstitialController.adFormats = [.banner]
                interstitialController.adConfigId = "123456789"
                interstitialController.adSize = .init(width: 320, height: 480)
            }
        ),
        TestCase(
            title: "Interstitial [Banner] [480x320]",
            storyboardId: "InterstitialAdVC",
            configurationClosure: { vc in
                let interstitialController = vc as! InterstitialAdVC
                interstitialController.adConfigId = "123456789"
                interstitialController.adFormats = [.banner]
                interstitialController.adSize = .init(width: 480, height: 320)
            }
        ),
        TestCase(
            title: "Interstitial [Video] [480x320]",
            storyboardId: "InterstitialAdVC",
            configurationClosure: { vc in
                let interstitialController = vc as! InterstitialAdVC
                interstitialController.adConfigId = "123456789"
                interstitialController.adFormats = [.video]
                interstitialController.adSize = .init(width: 480, height: 320)
            }
        ),
        TestCase(
            title: "Interstitial [Banner, Video] [Multi-Imp] [480x320]",
            storyboardId: "InterstitialAdVC",
            configurationClosure: { vc in
                let interstitialController = vc as! InterstitialAdVC
                interstitialController.adConfigId = "123456789"
                interstitialController.adFormats = [.banner, .video]
                interstitialController.adSize = .init(width: 480, height: 320)
            }
        ),
    ]

    // MARK: Rewardeded
    private static let rewarded: [TestCase] = [
        TestCase(
            title: "Rewarded [Video] [480x320]",
            storyboardId: "RewardedAdVC",
            configurationClosure: { vc in
                let rewardedAdController = vc as! RewardedAdVC
                rewardedAdController.adConfigId = "123456789"
                rewardedAdController.adFormats = [.video]
                rewardedAdController.adSize = .init(width: 480, height: 320)
            }
        ),
    ]
}

// MARK: - AppLovin Max

extension TestCase {
    private static let allAppLovinCases: [TestCase] = alBanners + alInterstitials + alRewarded

    // MARK: Banners
    private static let alBanners: [TestCase] = [
        TestCase(
            title: "Banner [320x50]",
            storyboardId: "MAXBannerAdVC",
            configurationClosure: { vc in
                let bannerController = vc as! MAXBannerAdVC
                bannerController.adSize = CGSize(width: 320, height: 50)
                bannerController.adConfigId = "123456789"
            }
        ),
        TestCase(
            title: "Banner [300x250]",
            storyboardId: "MAXBannerAdVC",
            configurationClosure: { vc in
                let bannerController = vc as! MAXBannerAdVC
                bannerController.adSize = CGSize(width: 300, height: 250)
                bannerController.adConfigId = "123456789"
            }
        ),
    ]

    // MARK: Interstitials
    private static let alInterstitials: [TestCase] = [
        TestCase(
            title: "Interstitial",
            storyboardId: "MAXInterstitialAdVC",
            configurationClosure: { vc in
                let interstitialController = vc as! MAXInterstitialAdVC
                interstitialController.adConfigId = "123456789"
            }
        ),
    ]

    // MARK: Rewardeded
    private static let alRewarded: [TestCase] = [
        TestCase(
            title: "Rewarded",
            storyboardId: "MAXRewardedAdVC",
            configurationClosure: { vc in
                let rewardedAdController = vc as! MAXRewardedAdVC
                rewardedAdController.adConfigId = "123456789"
            }
        ),
    ]
}
