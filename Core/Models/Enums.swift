//
//  Enums.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

enum CollectionPageDataSourceType  {

    case staticCollection
    case dynamicCollection
}


enum CollectionPageModel {
    case buildingsDataPage
    
    var dataSourceType: CollectionPageDataSourceType {
        switch self {
            
        case .buildingsDataPage:
            return .staticCollection
        }
    }
}
