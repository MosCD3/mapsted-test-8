//
//  File.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import Foundation


protocol CollectionViewDataSourceProtocol {
    func loadCollectionItemsData(callback: @escaping ([CollectionViewItem]) -> Void)
    func sourceType() -> CollectionPageDataSourceType
    func getSourceModel(index: Int)-> Any?
}
class CollectionViewDataSource: CollectionViewDataSourceProtocol {
    
    
    var collectionModel: CollectionPageModel
    var itemsArray: [Any]?
    
    init(pageMdoel: CollectionPageModel,
         itemsArray: [Any]?) {
        self.collectionModel = pageMdoel
        self.itemsArray = itemsArray
    }
    
    
    func loadCollectionItemsData(callback: @escaping ([CollectionViewItem]) -> Void) {
        
        
        switch collectionModel {
        case .buildingsDataPage:
            //TODO: load data for this collection page
            ()
        }
    }
    
    
    func sourceType() -> CollectionPageDataSourceType {
        switch collectionModel {
        case .buildingsDataPage:
            return .staticCollection
        }
    }
    
    func getSourceModel(index: Int)-> Any?  {
        return itemsArray?.getElement(at: index)
    }
}
