//
//  Models.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import SwiftyJSON

struct ApiResponse {
    var data: JSON?
    var error: String?
    var message: String?
    var popUpHandled: Bool?
    
}
