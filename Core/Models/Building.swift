//
//  Building.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import Foundation
class Building: NSObject, GenericBaseModel, NSCoding  {
    var building_id: Int?
    var building_name: String?
    var city: String?
    var state: String?
    var country: String?
    
    
    init(building_id: Int = 0,
         building_name: String?,
         city: String?,
         state: String? = nil,
         country: String? = nil) {
        self.building_id = building_id
        self.building_name = building_name
        self.city = city
        self.country = country
    }
    
    required public init(jsonDict: [String: Any]) {
        fatalError("Please use representation method")
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(building_id, forKey: "building_id")
        aCoder.encode(building_name, forKey: "building_name")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(country, forKey: "country")
    }
    
    public convenience required init?(coder aDecoder: NSCoder) {
        self.init(building_id: aDecoder.decodeObject(forKey: "building_id") as? Int ?? 0,
                  building_name: aDecoder.decodeObject(forKey: "building_name") as? String ?? nil,
                  city: aDecoder.decodeObject(forKey: "city") as? String ?? nil,
                  country: aDecoder.decodeObject(forKey: "country") as? String ?? nil)
    }
    
    public init(representation: [String: Any]) {
        self.building_id = representation["building_id"] as? Int ?? 0
        self.building_name = representation["building_name"] as? String
        self.city = representation["city"] as? String
        self.state = representation["state"] as? String
        self.country = representation["country"] as? String
        
    }
}
