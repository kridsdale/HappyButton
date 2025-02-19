//
//  HappyButtonApp.swift
//  HappyButton
//
//  Created by Kevin Ridsdale on 2/18/25.
//

import CarPlay
import SwiftData
import SwiftUI
import UIKit

import AVFoundation
import CarPlay
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session")
        }

        // Create and set the root view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        let contentView = ContentView()
        let hostingController = UIHostingController(rootView: contentView)
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.view.frame = UIScreen.main.bounds

        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()

        return true
    }

    func application(_: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options _: UIScene.ConnectionOptions) -> UISceneConfiguration
    {
        if connectingSceneSession.role == UISceneSession.Role.carTemplateApplication {
            let config = UISceneConfiguration(name: "CarPlay Scene", sessionRole: connectingSceneSession.role)
            config.delegateClass = CarPlaySceneDelegate.self
            return config
        }
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
