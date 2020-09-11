//
//  ServerConfig.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/10/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import UIKit

protocol ServerConfigurationProtocol {
    var appIdentifier: String {get}
    var isFirebaseAuthEnabled: Bool {get}
    var isFirebaseDatabaseEnabled: Bool {get}

}


class ServerConfig: ServerConfigurationProtocol {
    var appIdentifier: String = "classifieds-ios"

    var isFirebaseAuthEnabled: Bool = true
    var isFirebaseDatabaseEnabled: Bool = true
//    var homeGridViewServerCategory = ATCListingCategory(id: "55CyMgsgP0aT5Zp5eoDU",
//                                                        imageURLString: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwou-HC4d0iPq_L8lnmPrtykIbu9nVZT-XVuAnulyPBv90FcY2_A",
//                                                        title: "Phones & Tablets")
    static var adminEmail = "moscd3@gmail.com"
    static var Google_API_Key = "AIzaSyB-m8HzzlYuwCsPT8N76pB0pnZU-XRIi1o"
    static let dataBaseDateFormate = "yyyy-MM-dd"
}
