//
//  CarPlaySceneDelegate.swift
//  HappyButton
//
//  Created by Kevin Ridsdale on 2/18/25.
//

import CarPlay
import MediaPlayer
import UIKit

protocol CarPlayTemplateManager {
    func setupAudioInterface(_ interfaceController: CPInterfaceController)
    func cleanup()
}

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    var interfaceController: CPInterfaceController?
    private var templateManager: CarPlayTemplateManager?
    private var musicPlayer: MusicPlayerProtocol?

    override init() {
        super.init()
        musicPlayer = MusicPlayer()
        templateManager = CarPlayTemplateManagerImpl(musicPlayer: musicPlayer!)
    }

    func templateApplicationScene(_: CPTemplateApplicationScene,
                                  didConnect interfaceController: CPInterfaceController,
                                  to _: CPWindow)
    {
        self.interfaceController = interfaceController

        // Request media library authorization
        MPMediaLibrary.requestAuthorization { [weak self] status in
            guard status == .authorized else { return }
            self?.templateManager?.setupAudioInterface(interfaceController)
        }
    }

    func templateApplicationScene(_: CPTemplateApplicationScene,
                                  didDisconnect _: CPInterfaceController,
                                  from _: CPWindow)
    {
        templateManager?.cleanup()
        musicPlayer?.cleanup()
        print("CarPlay interface disconnected")
    }

    @available(iOS 14.0, *)
    func templateApplicationScene(_: CPTemplateApplicationScene,
                                  didConnect interfaceController: CPInterfaceController)
    {
        self.interfaceController = interfaceController
        // Request media library authorization
        MPMediaLibrary.requestAuthorization { [weak self] status in
            guard status == .authorized else { return }
            self?.templateManager?.setupAudioInterface(interfaceController)
        }
    }

    @available(iOS 14.0, *)
    func templateApplicationScene(_: CPTemplateApplicationScene,
                                  didDisconnectInterfaceController _: CPInterfaceController)
    {
        templateManager?.cleanup()
        musicPlayer?.cleanup()
    }

    func templateApplicationScene(_: CPTemplateApplicationScene,
                                  didSelect _: CPNavigationAlert)
    {
        // Not needed for audio player functionality
    }

    func templateApplicationScene(_: CPTemplateApplicationScene,
                                  didSelect _: CPManeuver)
    {
        // Not needed for audio player functionality
    }

    @available(iOS 15.4, *)
    func contentStyleDidChange(_: UIUserInterfaceStyle) {
        // No specific handling needed for audio player
    }

    func sceneDidDisconnect(_: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
