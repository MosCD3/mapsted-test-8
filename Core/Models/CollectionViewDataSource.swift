//
//  File.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import Foundation


protocol CollectionViewDataSourceProtocol: AnyObject {
    func loadCollectionItemsData(callback: @escaping ([CollectionViewItem]?) -> Void)
    func sourceType() -> CollectionPageDataSourceType
    func getSourceModel(index: Int)-> Any?
    func getMyCellDropDownData(tag: String) -> [String]?
    func getManifacturerCalcs(company:String) -> Double
    func getCategoryCalcs(category:String) -> Double
    func getCountryCalcs(country:String) -> Double
    func getStateCalcs(state:String) -> Double
    func getItemsCalcs(item:String) -> Double
    func getFamousBuildingName() -> String?
}
class CollectionViewDataSource: CollectionViewDataSourceProtocol {
    
    
    var collectionModel: CollectionPageModel
    var itemsArray: [Any]?
    var buildingsArray: [Building]?
    var analyticsArray: [AnalyticItem]?
    
    var manifacturerInfo: [String]?
    var categoryInfo: [String]?
    var countryInfo: [String]?
    var stateInfo: [String]?
    var itemsInfo: [String]?
    //TODO: Inject
    var mappingService: ModelMappingProtocol
    
    init(pageMdoel: CollectionPageModel,
         itemsArray: [Any]?, mapper: ModelMappingProtocol) {
        self.collectionModel = pageMdoel
        self.itemsArray = itemsArray
        self.mappingService = mapper
    }
    
    
    func loadCollectionItemsData(callback: @escaping ([CollectionViewItem]?) -> Void) {
        
        
        switch collectionModel {
        case .buildingsDataPage:
            
            
            
            //TODO: load data for this collection page
            let api = APIService()
            
            
            //Loading Buildings
            api.postData(endpoint: APIUri.buildingsUri) {
                result in
                if let response = result.data {
                    if let mappedBuldings = self.mappingService.map(data: response, type: .buildingData) as? [Building] {
                        LogService.shared.log(message: "API> got buildings")
                        self.buildingsArray = mappedBuldings
                        
                        //Loading Analytics Data
                        api.postData(endpoint: .analyticsUri) {
                            anResult in
                            if let an_response = anResult.data {
                                LogService.shared.log(message: "API> got analytics")
                                if let anaylyticsArr = self.mappingService.map(data: an_response, type: .analyticsData) as? [AnalyticItem] {
                                    self.analyticsArray = anaylyticsArr
                                    callback(nil)
                                    return
                                } else {
                                    LogService.shared.error(message: "cannot map analytics array")
                                }
                                
                            }
                        }
                        
                    } else {
                        LogService.shared.error(message: "error dts86")
                    }
                    
                }
                
            }
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
    
    //MARK: Source for Cell Data
    func getMyCellDropDownData(tag: String) -> [String]? {
        
        switch tag {
        case "manufacturerInfo":
            if let mList = self.manifacturerInfo {
                return mList
            } else {
                if let res = getManifacturerList() {
                    self.manifacturerInfo = res
                    return self.manifacturerInfo
                }
            }
        case "categoryInfo":
            if let mList = self.categoryInfo {
                return mList
            } else {
                if let res = getCategoryList() {
                    self.categoryInfo = res
                    return self.categoryInfo
                }
            }
        case "countryInfo":
            if let mList = self.countryInfo {
                return mList
            } else {
                if let res = getCountryList() {
                    self.countryInfo = res
                    return self.countryInfo
                }
            }
            
        case "stateInfo":
            if let mList = self.stateInfo {
                return mList
            } else {
                if let res = getStateList() {
                    self.stateInfo = res
                    return self.stateInfo
                }
            }
        case "itemsInfo":
            if let mList = self.itemsInfo {
                return mList
            } else {
                if let res = getItemsList() {
                    self.itemsInfo = res
                    return self.itemsInfo
                }
            }
            
        default:
            LogService.shared.error(message: "Cannot get cell source for tag:\(tag)")
        }
        return nil
    }
    
    func getFamousBuildingName() -> String? {
        
        guard let analyticsArray = self.analyticsArray else {
            LogService.shared.error(message: "getFamousBuildingName> analytics array nil")
            return nil
            
        }
        guard let buildingsArray = self.buildingsArray else {
            LogService.shared.error(message: "getFamousBuildingName> buildingsArray array nil")
            return nil
            
        }
        
        var topCosts: Double = 0
        var topBuilding: String = ""
        
        for building in buildingsArray {
            
            var totalCost: Double = 0
            for anItem in analyticsArray {
                for session in anItem.usage_statistics {
                    
                    if session.building_id == building.building_id {
                        for purchase in session.purchases {
                            totalCost += purchase.cost
                        }
                    }
                }
                
            }
            
            if totalCost > topCosts {
                topCosts = totalCost
                topBuilding = building.building_name ?? ""
            }
            
        }
        
        return topBuilding
        
    }
    
    
    //MARK: Selected Dropdown event handlers
    func getManifacturerCalcs(company:String) -> Double {
        guard let analyticsArray = self.analyticsArray else {
            LogService.shared.error(message: "getManifacturerCalcs> analytics array nil")
            return 0
            
        }
        
        var totalCost: Double = 0
        for anItem in analyticsArray {
            if anItem.manufacturer == company {
                for session in anItem.usage_statistics {
                    for purchase in session.purchases {
                        totalCost += purchase.cost
                    }
                }
            }
        }
        if totalCost > 0 {
            totalCost = Utils.formateDouble(totalCost)
        }
        return totalCost
    }
    
    func getCategoryCalcs(category:String) -> Double {
        guard let analyticsArray = self.analyticsArray else {
            LogService.shared.error(message: "getCategoryCalcs> analytics array nil")
            return 0
            
        }
        
        guard let categoryNum = Int(category) else {
            LogService.shared.error(message: "getCategoryCalcs> cannot parse cat to int:\(category)")
            return 0
        }
        
        var totalCost: Double = 0
        for anItem in analyticsArray {
            for session in anItem.usage_statistics {
                for purchase in session.purchases {
                    if purchase.item_category_id == categoryNum {
                        totalCost += purchase.cost
                    }
                }
            }
        }
        if totalCost > 0 {
            totalCost = Utils.formateDouble(totalCost)
        }
        return totalCost
    }
    
    func getCountryCalcs(country:String) -> Double {
        //first get list of all buildings in country
        
        guard let analyticsArray = self.analyticsArray else {
            LogService.shared.error(message: "getCountryCalcs> analytics array nil")
            return 0
            
        }
        guard let buildingsArray = self.buildingsArray else {
            LogService.shared.error(message: "getCountryCalcs> buildingsArray array nil")
            return 0
            
        }
        
        let buildings = buildingsArray.filter {
            row in
            return row.country == country
        }
        
        var totalCost: Double = 0
        
        //Loop each building and find all sum data for that building
        for building in buildings {
            
            for anItem in analyticsArray {
                for session in anItem.usage_statistics {
                    if session.building_id == building.building_id {
                        for purchase in session.purchases {
                            totalCost += purchase.cost
                        }
                    }
                }
            }
            
        }
        
        if totalCost > 0 {
            totalCost = Utils.formateDouble(totalCost)
        }
        
        return totalCost
    }
    
    
    func getStateCalcs(state:String) -> Double {
        //first get list of all buildings in country
        
        guard let analyticsArray = self.analyticsArray else {
            LogService.shared.error(message: "getCountryCalcs> analytics array nil")
            return 0
            
        }
        guard let buildingsArray = self.buildingsArray else {
            LogService.shared.error(message: "getCountryCalcs> buildingsArray array nil")
            return 0
            
        }
        
        let buildings = buildingsArray.filter {
            row in
            return row.state == state
        }
        
        var totalCost: Double = 0
        
        //Loop each building and find all sum data for that building
        for building in buildings {
            
            for anItem in analyticsArray {
                for session in anItem.usage_statistics {
                    if session.building_id == building.building_id {
                        for purchase in session.purchases {
                            totalCost += purchase.cost
                        }
                    }
                }
            }
            
        }
        
        if totalCost > 0 {
            totalCost = Utils.formateDouble(totalCost)
        }
        
        return totalCost
    }
    
    func getItemsCalcs(item:String) -> Double {
        guard let analyticsArray = self.analyticsArray else {
            LogService.shared.error(message: "getItemsCalcs> analytics array nil")
            return 0
            
        }
        
        guard let itemNum = Int(item) else {
            LogService.shared.error(message: "getItemsCalcs> cannot parse cat to int:\(item)")
            return 0
        }
        
        var totalCost: Double = 0
        for anItem in analyticsArray {
            for session in anItem.usage_statistics {
                for purchase in session.purchases {
                    if purchase.item_id == itemNum {
                        totalCost += 1
                    }
                }
            }
        }
        return totalCost
    }
    
    
    //MARK: Private methods
    private func getManifacturerList() -> [String]? {
        guard let analyticsArray = self.analyticsArray else {return nil}
        
        let unfiltered: [String] = analyticsArray.map { row in
            return row.manufacturer
        }
        
        var filtered = Array(Set(unfiltered))
        filtered.insert("Select Manifacturer", at: 0)
        return filtered
    }
    
    private func getCategoryList() -> [String]? {
        guard let analyticsArray = self.analyticsArray else {return nil}
        
        
        var cats : [Int] = []
        for item in  analyticsArray {
            for usage in item.usage_statistics {
                for session in usage.purchases {
                    cats.append(session.item_category_id)
                }
            }
        }
        
        
        let filtered = Array(Set(cats))
        var converted = filtered.map{String($0)}
        converted.insert("Select Category", at: 0)
        return converted
    }
    
    private func getCountryList() -> [String]? {
        guard let buildingsArray = self.buildingsArray else {
            LogService.shared.error(message: "getCountryList> buildingsArray nil")
            return nil
            
        }
        let unsorted : [String] = buildingsArray.map { $0.country ?? "" }
        var filtered = Array(Set(unsorted))
        filtered.insert("Select Country", at: 0)
        return filtered
    }
    
    private func getStateList() -> [String]? {
        guard let buildingsArray = self.buildingsArray else {
            LogService.shared.error(message: "getCountryList> buildingsArray nil")
            return nil
            
        }
        let unsorted : [String] = buildingsArray.map { $0.state ?? "" }
        var filtered = Array(Set(unsorted))
        filtered.insert("Select State", at: 0)
        return filtered
    }
    
    private func getItemsList() -> [String]? {
        guard let analyticsArray = self.analyticsArray else {return nil}
        
        
        var items : [Int] = []
        for item in  analyticsArray {
            for usage in item.usage_statistics {
                for session in usage.purchases {
                    items.append(session.item_id)
                }
            }
        }
        
        
        let filtered = Array(Set(items))
        var converted = filtered.map{String($0)}
        converted.insert("Select Item", at: 0)
        return converted
    }
    
    
    
}
