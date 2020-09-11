//
//  Utils.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import UIKit

//MARK:  General Utils
struct Utils {
    static func isInternetConnected() -> Bool {
        return Reachability.isConnectedToNetwork()
    }
}
