//
//  File.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import Foundation


protocol CollectionViewDataSourceProtocol: AnyObject {
    func loadCollectionItemsData(callback: @escaping ([CollectionViewItem]) -> Void)
    func sourceType() -> CollectionPageDataSourceType
    func getSourceModel(index: Int)-> Any?
}
class CollectionViewDataSource: CollectionViewDataSourceProtocol {
    
    
    var collectionModel: CollectionPageModel
    var itemsArray: [Any]?
    var buildingsArray: [Building]?
    var analyticsArray: [AnalyticItem]?
    //TODO: Inject
    let mappingService = ModelMapping()
    
    init(pageMdoel: CollectionPageModel,
         itemsArray: [Any]?) {
        self.collectionModel = pageMdoel
        self.itemsArray = itemsArray
    }
    
    
    func loadCollectionItemsData(callback: @escaping ([CollectionViewItem]) -> Void) {
        
        
        switch collectionModel {
        case .buildingsDataPage:
            
            
            
            //TODO: load data for this collection page
            let api = APIService()
            
            
            //Loading Buildings
            api.postData(endpoint: APIUri.buildingsUri) {
                result in
                if let response = result.data {
                    if let mappedBuldings = self.mappingService.map(data: response, type: .buildingData) as? [Building] {
                        print("horaaaaaay got buildings")
                        
                        self.buildingsArray = mappedBuldings
                        
                        //Loading Analytics Data
                        api.postData(endpoint: .analyticsUri) {
                            anResult in
                             if let an_response = anResult.data {
                                print("horaaaaay loaded analytics")
                                if let anaylyticsArr = self.mappingService.map(data: an_response, type: .analyticsData) as? [AnalyticItem] {
                                    print("yessssss analytics array count:", anaylyticsArr.count)
                                    
                                    self.analyticsArray = anaylyticsArr
                                } else {
                                    print("Oh no cannot map analytics array")
                                }
                                
                             } else {
                                print("67 cannot load analytics data")
                            }
                        }
                        
                        
                        
                    } else {
                        print("nooooo")
                    }
                    
                } else {
                    print("cannot load buildings data")
                }
                
            }
            print("load data")
        }
    }
    
    
    func sourceType() -> CollectionPageDataSourceType {
        switch collectionModel {
        case .buildingsDataPage:
            return .dynamicCollection
        }
    }
    
    func getSourceModel(index: Int)-> Any?  {
        return itemsArray?.getElement(at: index)
    }
    

    
}
