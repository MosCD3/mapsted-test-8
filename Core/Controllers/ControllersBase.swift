//
//  ControllersBase.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import Foundation

open class ControllersBase {
    
    var mainCoordinator: GenericCoordinatorProtocol
    var uiConfig: UIConfigurationProtocol
    
    init(mainCoordinator: GenericCoordinatorProtocol,
         uiConfig: UIConfigurationProtocol) {
        self.mainCoordinator = mainCoordinator
        self.uiConfig = uiConfig
    }
}
