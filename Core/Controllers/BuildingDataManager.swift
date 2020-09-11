//
//  BuildingDataManager.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import Foundation

protocol BuildingDataManagerDelegate: AnyObject {
    func gotBuildingInfo()
}

class BuildingDataManager: ControllersBase {
    
    public weak var delegate: BuildingDataManagerDelegate?
    
    
    public func getViewController() -> BuildingsDataViewController {
    
        let vc = BuildingsDataViewController(coordinator: self.mainCoordinator)
        return vc
    }
}

extension BuildingDataManager: BuildingsDataViewControllerDelegate {
    func viewDidLoad() {
        print("please load data")
    }
}
