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
    func getCurrentVC() ->UIViewController?
}

protocol MainCoordinatorEventDelegate: AnyObject {
}


class MainCoordinator: GenericCoordinatorProtocol {

    
    
    let uiConfig: UIConfigurationProtocol
    let appWindow: UIWindow
    
    //MARK:Controllers/Screens
    var buildingsPageController: BuildingDataManager?
    var buildingsPageScreen: BuildingsDataViewController?
    
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
        
        let buildingsManager = BuildingDataManager(mainCoordinator: self,
                                                   uiConfig: self.uiConfig)
        let buildingsScreen = buildingsManager.getViewController()
       
        self.buildingsPageController = buildingsManager
        self.buildingsPageScreen = buildingsScreen
        
        self.navController?.pushViewController(buildingsScreen, animated: true)
        
        
    }
    
    func getCurrentVC() ->UIViewController? {
        return appWindow.rootViewController
    }
    
    //MARK: Private properties
    private var navController: UINavigationController?
    
}
