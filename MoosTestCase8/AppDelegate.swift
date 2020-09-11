//
//  AppDelegate.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/10/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let uiConfig = UIConfiguration()
        uiConfig.configureUI()
        
        
        let settings = Settings()
        
        let serverConfig = ServerConfig()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = MainCoordinator(appWindow: window!, uiConfig: uiConfig)
        
        AlertService.shared.setCoordinator(coordinator: coordinator)
        
        coordinator.startApp(uiConfig: uiConfig, settingsProvider: settings, serverConfig: serverConfig)
        self.coordinator = coordinator
        
        return true
    }

}

