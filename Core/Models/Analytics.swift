//
//  Analytics.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

struct Purchase {
    var item_id: Int
    var item_category_id: Int
    var cost: Double
}

struct Session {
    var building_id: Int
    var purchases: [Purchase]
}

struct AnalyticItem {
    var manufacturer: String
    var market_name: String
    var codename: String
    var model: String
   var  usage_statistics: [Session]
}
