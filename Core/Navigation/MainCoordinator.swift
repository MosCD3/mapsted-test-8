//
//  MainCoordinator.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/10/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import UIKit
protocol GenericCoordinatorProtocol {
//    func startApp(uiConfig:  AZoneUIConfigurationProtocol, settingsProvider: SettingsProvider, serverConfig: ServerConfig)
    var delegate: MainCoordinatorEventDelegate? {get set}
    
    func startApp(uiConfig:  UIConfigurationProtocol,
                  settingsProvider: SettingsProtocol,
                  serverConfig: ServerConfigurationProtocol)
    
    func navToBuildingData()
}

protocol MainCoordinatorEventDelegate: AnyObject {
}


class MainCoordinator: GenericCoordinatorProtocol {

    
    
    let uiConfig: UIConfigurationProtocol
    let appWindow: UIWindow
    
    init(appWindow: UIWindow,
         uiConfig: UIConfigurationProtocol) {
        self.appWindow = appWindow
        self.uiConfig = uiConfig
        
    }
    
    //MARK: Public properties
    weak var delegate: MainCoordinatorEventDelegate?
    func startApp(uiConfig:  UIConfigurationProtocol,
                  settingsProvider: SettingsProtocol,
                  serverConfig: ServerConfigurationProtocol) {
        
        let vc = WelcomePage(coordinator: self)
        let navController = UINavigationController(rootViewController: vc)
        self.navController = navController
        self.appWindow.rootViewController = navController
        self.appWindow.makeKeyAndVisible()
    }
    
    func navToBuildingData() {
        let vc = BuildingsDataViewController(coordinator: self)
        self.navController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Private properties
    private var navController: UINavigationController?
    
}
