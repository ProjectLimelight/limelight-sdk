//
//  AppDelegate.swift
//  DemoSwift
//
// © 2026 Limelight Inc. All Rights Reserved.
//

import AppLovinSDK
import LimelightSDK
import LimelightSDKAppLovinAdapter
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        setupAppLovin()
        setupLimelightSDK()
        return true
    }

    private func setupLimelightSDK() {
        Limelight.logLevel = .info
        Limelight.initialize(host: "https://ads-forty-flsk9l.ortb.net/openrtb/526274869", completion: { result in
            switch result {
            case let .success(status):
                print("Limelight successfully initialized: \(status)")
            case let .failure(error):
                print("Limelight initialization failed: \(error)")
            }
        })
    }

    private func setupAppLovin() {
        // Set ALSdk settings
        ALSdk.shared().settings.isVerboseLoggingEnabled = true
        ALSdk.shared().settings.isMuted = true

        // Create the initialization configuration
        let configuration = ALSdkInitializationConfiguration(sdkKey: "<SDK-KEY>", builderBlock: { builder in
            builder.mediationProvider = ALMediationProviderMAX

            // Enable test mode by default for the current device.
            if let currentIDFV = UIDevice.current.identifierForVendor?.uuidString {
                builder.testDeviceAdvertisingIdentifiers = [currentIDFV]
            }
        })

        // Initialize the SDK with the configuration
        ALSdk.shared().initialize(with: configuration, completionHandler: { alSdkConfiguration in
            // AppLovin SDK is initialized, start loading ads now or later if ad gate is reached
        })
    }
}
