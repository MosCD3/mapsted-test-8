//
//  MappingService.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import Foundation
import SwiftyJSON
class ModelMapping {
    func map(data:JSON, type: ModelType) -> Any? {
        
        switch type {
        case .buildingData:
            var allBuildings: [Building] = []
            for item in data {
                
                let jsonObject = item.1
                //                debugPrint("object is:", jsonObject.dictionaryObject)
                if let representation = jsonObject.dictionaryObject {
                    allBuildings.append(Building(representation: representation))
                }
            }
            
            return allBuildings
        case .analyticsData:
            var allAnalytics: [AnalyticItem] = []
            for analyticItem in data {
                
                let jsonObject = analyticItem.1
                //                debugPrint("object is:", jsonObject.dictionaryObject)
                
                var sessions: [Session] = []
                for s_val in jsonObject["usage_statistics"]["session_infos"] {
                    if let _session = map(data: s_val.1, type: .sessionInfo) as? Session {
                        sessions.append(_session)
                    }
                }
            
                
                allAnalytics.append(AnalyticItem(
                    manufacturer: jsonObject["manufacturer"].string ?? "",
                    market_name: jsonObject["market_name"].string ?? "",
                    codename: jsonObject["codename"].string ?? "",
                    model: jsonObject["model"].string ?? "",
                    usage_statistics: sessions))
            }
            
            return allAnalytics
            
        case .sessionInfo:
        
            var purchasesArr: [Purchase] = []
            if let purchases = map(data: data["purchases"], type: .purchase) as? [Purchase] {
                purchasesArr = purchases
            }
            
            return Session(building_id: data["building_id"].int ?? 0, purchases: purchasesArr)
            
        case .purchase:
            
            var purchases: [Purchase] = []
            
            for item in data {
                 let jsonObject = item.1
                purchases.append(Purchase(
                    item_id: jsonObject["item_id"].int ?? 0,
                    item_category_id: jsonObject["item_category_id"].int ?? 0,
                    cost: jsonObject["cost"].double ?? 0))
            }
            return purchases
            
        default:
            LogService.shared.error(message: "Cannot find mapping action for uri:\(type)", type: .logicalError)
        }
        
        return nil
    }
}
