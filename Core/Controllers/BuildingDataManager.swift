//
//  BuildingDataManager.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import Foundation

protocol BuildingDataManagerDelegate: AnyObject {
    
}

class BuildingDataManager: ControllersBase {
    
    public weak var delegate: BuildingDataManagerDelegate?
    
    
    public func getViewController() -> BuildingsDataViewController {
    
        let vc = BuildingsDataViewController(coordinator: self.mainCoordinator, uiConfig: self.uiConfig)
        return vc
    }
}

extension BuildingDataManager: BuildingsDataViewControllerDelegate {

}
