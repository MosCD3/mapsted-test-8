//
//  Enums.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

fileprivate var apiBase: String {
    get {
        return Settings.apiBase
    }
}

enum ModelType {
    case buildingData, analyticsData, sessionInfo, purchase
}

enum CollectionPageDataSourceType  {

    case staticCollection
    case dynamicCollection
}


enum CollectionPageModel {
    case buildingsDataPage
    
    var dataSourceType: CollectionPageDataSourceType {
        switch self {
            
        case .buildingsDataPage:
            return .dynamicCollection
        }
    }
}

//http://positioning-test.mapsted.com/api/Values/GetBuildingData/
//http://positioning-test.mapsted.com/api/Values/GetAnalyticData/

enum APIUri: String, CaseIterable {
    
    case buildingsUri, analyticsUri
    var uri: String? {
        switch self {
        case .buildingsUri:
            return "\(apiBase)/GetBuildingData/"
            
        case .analyticsUri:
            return "\(apiBase)/GetAnalyticData/"
        }
    }
}
